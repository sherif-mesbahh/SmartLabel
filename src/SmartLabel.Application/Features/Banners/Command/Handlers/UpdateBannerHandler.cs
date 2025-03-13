using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Banners.Command.Handlers
{
	public class UpdateBannerHandler(IMapper mapper, IBannerRepository repository) : ResponseHandler, IRequestHandler<UpdateBannerCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(UpdateBannerCommand request, CancellationToken cancellationToken)
		{
			var banner = mapper.Map<Banner>(request);
			await repository.UpdateBanner(banner);
			return Updated<string>("Banner is Updated successfully");
		}
	}
}
