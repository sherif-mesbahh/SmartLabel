using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Repositories;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetActiveBannersHandler(IBannerRepository repository) : ResponseHandler, IRequestHandler<GetActiveBannersQuery, Response<IEnumerable<GetBannersDto?>>>
{
	public async Task<Response<IEnumerable<GetBannersDto?>>> Handle(GetActiveBannersQuery request, CancellationToken cancellationToken)
	{
		var activeBanners = await repository.GetActiveBannersAsync();
		return Success(activeBanners, "Active banners retrieved successfully");
	}
}
