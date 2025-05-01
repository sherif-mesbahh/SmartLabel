using AutoMapper;
using MediatR;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;

namespace SmartLabel.Application.Features.Products.Command.Handlers;
public class UpdateProductHandler(IMapper mapper, IProductRepository productRepository, IFileService fileService, IUnitOfWork unitOfWork)
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
			await fileService.DeleteImageAsync(mainImage);
			if (!request.RemovedImageIds.IsNullOrEmpty())
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
			await unitOfWork.SaveChangesAsync(cancellationToken);
			await productRepository.UpdateProductAsync(product.Id, product);
			transaction.Commit();
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>([ex.Message], "Updating product temporarily unavailable");
		}
	}
}
