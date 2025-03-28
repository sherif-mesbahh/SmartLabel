using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Products.Command.Handlers;
public class UpdateProductHandler(IMapper mapper, IProductRepository productRepository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<UpdateProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateProductCommand request, CancellationToken cancellationToken)
	{

		if (!await productRepository.IsProductExistAsync(request.Id))
		{
			return NotFound<string>($"The product with id {request.Id} is not found");
		}

		using var transaction = await unitOfWork.BeginTransaction();
		try
		{
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
			await productRepository.UpdateProductAsync(product.Id, product);
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
			transaction.Commit();
			return Updated<string>($"Product with id {product.Id} is Updated successfully");
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>($"{ex.Message}");
		}
	}
}
