using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Repositories;
using GetBannerByIdDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannerByIdDto;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetBannerByIdHandler(IBannerRepository repository) : ResponseHandler, IRequestHandler<GetBannerByIdQuery, Response<GetBannerByIdDto>>
{
	public async Task<Response<GetBannerByIdDto>> Handle(GetBannerByIdQuery request, CancellationToken cancellationToken)
	{
		var banner = await repository.GetBannerByIdAsync(request.Id);
		if (banner is null)
			return NotFound<GetBannerByIdDto>([$"Banner ID: {request.Id} not found"], "Banner discontinued");
		return Success(banner, $"Banner {request.Id} retrieved successfully");
	}
}