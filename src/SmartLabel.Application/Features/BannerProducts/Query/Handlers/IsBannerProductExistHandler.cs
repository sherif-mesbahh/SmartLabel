using MediatR;
using SmartLabel.Application.Features.BannerProducts.Query.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.BannerProducts.Query.Handlers
{
	public class IsBannerProductExistHandler(IBannerProductRepository repository) : IRequestHandler<IsBannerProductExistQuery, bool>
	{
		public async Task<bool> Handle(IsBannerProductExistQuery request, CancellationToken cancellationToken)
		{
			return await repository.IsBannerProductExist(request.BannerId, request.ProductId);
		}
	}
}
