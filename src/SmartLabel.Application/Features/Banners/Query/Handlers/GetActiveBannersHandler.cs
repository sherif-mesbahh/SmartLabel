using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.Banners;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetActiveBannersHandler(IBannerRepository repository) : ResponseHandler, IRequestHandler<GetActiveBannersQuery, Response<IEnumerable<GetBannersDto?>>>
{
	public async Task<Response<IEnumerable<GetBannersDto?>>> Handle(GetActiveBannersQuery request, CancellationToken cancellationToken)
	{
		var activeBanners = await repository.GetActiveBannersAsync();
		return Success(activeBanners, "All Active Banners are getting successfully");
	}
}
