using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Helpers;
using SmartLabel.Domain.Interfaces;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Products.Command.Handlers;

public class AddProductHandler(IMapper mapper, IProductRepository repository, IFileService fileService,
	IUnitOfWork unitOfWork, IHttpContextAccessor httpContextAccessor, IMemoryCache memoryCache)
	: ResponseHandler, IRequestHandler<AddProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddProductCommand request, CancellationToken cancellationToken)
	{
		using var transaction = await unitOfWork.BeginTransaction();
		try
		{
			var product = mapper.Map<Product>(request);
			if (request.MainImage != null) product.MainImage = await fileService.BuildImageAsync(request.MainImage);
			await repository.AddProductAsync(product);
			await unitOfWork.SaveChangesAsync(cancellationToken);
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
				await repository.AddProductImagesAsync(productImages);
			}

			await unitOfWork.SaveChangesAsync(cancellationToken);
			var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
			InvalidCache(userId, product.Id);
			transaction.Commit();
			return Created<string>($"Product with {product.Id} is added successfully");
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>([ex.Message], "Adding product temporarily unavailable");
		}
	}
	private void InvalidCache(string? userId, int productId)
	{
		memoryCache.Remove($"ProductsUserId-");
		memoryCache.Remove($"ProductsUserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-");
	}
}
