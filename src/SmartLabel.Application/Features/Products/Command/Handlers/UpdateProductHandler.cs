using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Helpers;
using SmartLabel.Domain.Interfaces;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Products.Command.Handlers;
public class UpdateProductHandler(IMapper mapper, IProductRepository productRepository, IMemoryCache memoryCache, IHttpContextAccessor httpContextAccessor,
	IUserFavProductRepository userFavProductRepository,
	INotifierService notifierService, IFileService fileService,
	INotificationRepository notificationRepository, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<UpdateProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateProductCommand request, CancellationToken cancellationToken)
	{


		if (!await productRepository.IsProductExistAsync(request.Id))
			return NotFound<string>([$"Product ID: {request.Id} not found"], "Product discontinued");
		using var transaction = await unitOfWork.BeginTransaction();
		try
		{
			var mainImage = await productRepository.GetProductImage(request.Id);
			if (request.MainImage is not null) await fileService.DeleteImageAsync(mainImage);
			if (request.RemovedImageIds is not null)
			{
				var imageUrls = await productRepository.GetProductImageUrlsByIdsAsync(request.RemovedImageIds);
				foreach (var imageUrl in imageUrls)
				{
					await fileService.DeleteImageAsync(imageUrl);
				}
				await productRepository.DeleteProductImagesAsync(request.RemovedImageIds);
			}
			var product = mapper.Map<Product>(request);
			if (request.MainImage != null) product.MainImage = await fileService.BuildImageAsync(request.MainImage);
			var price = await productRepository.GetProductPriceAsync(request.Id);
			if (request.ImagesFiles is not null)
			{
				var productImages = new List<ProductImage>();
				foreach (var image in request.ImagesFiles)
				{
					var productImage = new ProductImage()
					{
						Id = 0,
						ImageUrl = await fileService.BuildImageAsync(image),
						ProductId = product.Id
					};
					productImages.Add(productImage);
				}
				await productRepository.AddProductImagesAsync(productImages);
			}

			var message = $"price of {product.Name} product has been updated to {product.NewPrice}";
			await productRepository.UpdateProductAsync(product.Id, product, mainImage);
			if (product.NewPrice != price)
			{
				var userIds = await userFavProductRepository.GetUsersByProductId(product.Id);
				foreach (var userId in userIds)
				{

					await notifierService.SendToGroup($"user-{userId.ToString()}", message);
				}
				await notificationRepository.AddNotificationToUsers(message, userIds, (int)EntityEnum.Product, product.Id);
			}
			await unitOfWork.SaveChangesAsync(cancellationToken);
			var userID = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
			InvalidCache(userID, product.Id, product.CatId);
			transaction.Commit();
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>([ex.Message], "Updating product temporarily unavailable");
		}
	}
	private void InvalidCache(string userId, int productId, int categoryId)
	{
		memoryCache.Remove($"ProductsUserId-");
		memoryCache.Remove($"ProductsUserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-{userId}");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-");
		memoryCache.Remove($"ProductsFav-{userId}");
	}
}
