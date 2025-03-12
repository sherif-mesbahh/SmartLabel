using AutoMapper;
using MediatR;
using SmartLabel.Application.Features.BannerProducts.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.BannerProducts.Command.Handlers
{
	public class AddBannerProductHandler(IMapper mapper, IBannerProductRepository repository) : IRequestHandler<AddBannerProductCommand>
	{
		public async Task Handle(AddBannerProductCommand request, CancellationToken cancellationToken)
		{
			try
			{
				var bannerProduct = mapper.Map<BannerProduct>(request);
				await repository.AddBannerProduct(bannerProduct);
			}
			catch (Exception ex)
			{

			}
		}
	}
}
