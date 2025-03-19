using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetActiveBannersHandler(IMapper mapper, IBannerRepository repository) : ResponseHandler, IRequestHandler<GetActiveBannersQuery, Response<IEnumerable<GetBannerResult>>>
{
	public async Task<Response<IEnumerable<GetBannerResult>>> Handle(GetActiveBannersQuery request, CancellationToken cancellationToken)
	{
		var activeBanners = mapper.Map<IEnumerable<GetBannerResult>>(await repository.GetActiveBanners());
		return Success(activeBanners, "All Active Banners getting successfully");
	}
}
