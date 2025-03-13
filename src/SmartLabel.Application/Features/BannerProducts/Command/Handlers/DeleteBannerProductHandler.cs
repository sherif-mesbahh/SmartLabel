using MediatR;
using SmartLabel.Application.Features.BannerProducts.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.BannerProducts.Command.Handlers
{
	public class DeleteBannerProductHandler(IBannerProductRepository repository) : IRequestHandler<DeleteBannerProductCommand>
	{
		public async Task Handle(DeleteBannerProductCommand request, CancellationToken cancellationToken)
		{
			await repository.DeleteBannerProduct(request.BannerId, request.ProductId);
		}
	}
}
