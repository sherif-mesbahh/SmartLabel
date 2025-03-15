using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Products.Command.Handlers
{
	public class UpdateProductHandler(IMapper mapper, IProductRepository repository, IFileService fileService) : ResponseHandler, IRequestHandler<UpdateProductCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(UpdateProductCommand request, CancellationToken cancellationToken)
		{
			if (request.RemovedImageIds != null)
			{
				foreach (var imageId in request.RemovedImageIds)
				{
					var productImage = await repository.GetProductImageById(imageId);
					if (productImage is null) continue;
					await fileService.DeleteImageAsync(productImage.ImageUrl);
					await repository.DeleteProductImage(productImage);
				}
			}
			var product = mapper.Map<Product>(request);
			await repository.UpdateProduct(product);
			if (request.ImagesFiles is not null)
			{
				foreach (var image in request.ImagesFiles)
				{
					var productImage = new ProductImage()
					{
						Id = 0,
						ImageUrl = await fileService.BuildImageAsync(image),
						ProductId = product.Id
					};
					await repository.AddProductImage(productImage);
				}
			}
			return Updated<string>("Product is Updated successfully");
		}
	}
}
