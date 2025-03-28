using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.Banners;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetBannerByIdHandler(IBannerRepository repository) : ResponseHandler, IRequestHandler<GetBannerByIdQuery, Response<GetBannerByIdDto>>
{
	public async Task<Response<GetBannerByIdDto>> Handle(GetBannerByIdQuery request, CancellationToken cancellationToken)
	{
		var banner = await repository.GetBannerByIdAsync(request.Id);
		if (banner is null)
			return NotFound<GetBannerByIdDto>("Banner with id " + request.Id + " not found");
		return Success(banner, $"Banner with id {request.Id} is getting successfully");
	}
}