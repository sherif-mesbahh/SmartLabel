using MediatR;
using SmartLabel.Application.Features.ProductImages.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.ProductImages.Command.Handlers
{
	public class DeleteProductImageHandler(IProductImageRepository repository) : IRequestHandler<DeleteProductImageCommand>
	{
		public async Task Handle(DeleteProductImageCommand request, CancellationToken cancellationToken)
		{
			var productImage = await repository.GetProductImageById(request.Id);
			await repository.DeleteProductImage(productImage);
		}
	}
}
