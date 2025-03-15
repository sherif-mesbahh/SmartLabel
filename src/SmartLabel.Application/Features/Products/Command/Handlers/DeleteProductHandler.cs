using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Products.Command.Handlers
{
	public class DeleteProductHandler(IProductRepository repository, IFileService fileService) : ResponseHandler, IRequestHandler<DeleteProductCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(DeleteProductCommand request, CancellationToken cancellationToken)
		{
			var product = await repository.GetProductById(request.Id);
			if (product?.Images is not null)
			{
				foreach (var image in product.Images)
				{
					await fileService.DeleteImageAsync(image.ImageUrl);
				}
			}
			await repository.DeleteProduct(product);
			return Deleted<string>("This product is deleted Successfully");
		}
	}
}
