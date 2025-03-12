using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Banners.Command.Handlers
{
	public class AddBannerHandler(IMapper mapper, IBannerRepository repository) : ResponseHandler, IRequestHandler<AddBannerCommand, Response<AddBannerCommand>>
	{
		public async Task<Response<AddBannerCommand>> Handle(AddBannerCommand request, CancellationToken cancellationToken)
		{
			var banner = mapper.Map<Banner>(request);
			await repository.AddBanner(banner);
			request.Id = banner.Id;
			return Created(request, "Banner is added successfully");
		}
	}
}
