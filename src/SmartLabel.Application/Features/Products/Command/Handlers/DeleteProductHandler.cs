using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Products.Command.Handlers
{
	public class DeleteProductHandler(IProductRepository repository) : ResponseHandler, IRequestHandler<DeleteProductCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(DeleteProductCommand request, CancellationToken cancellationToken)
		{
			var product = await repository.GetProductById(request.Id);
			await repository.DeleteProduct(product);
			return Deleted<string>("This product is deleted Successfully");
		}
	}
}
