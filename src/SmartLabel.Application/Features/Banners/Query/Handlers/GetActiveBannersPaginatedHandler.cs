using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
internal sealed class GetActiveBannersPaginatedHandler(IBannerProcRepository bannerRepository, IMemoryCache memoryCache) :
	IRequestHandler<GetActiveBannersPaginatedQuery, PagedList<GetBannersDto>>
{
	public async Task<PagedList<GetBannersDto>> Handle(GetActiveBannersPaginatedQuery request, CancellationToken cancellationToken)
	{
		(int totalCount, var activeBan) = await bannerRepository.GetActiveBannersPaged(request);
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var banners = await PagedList<GetBannersDto>.CreateAsync(activeBan, totalCount, page, pageSize);
		return banners;
	}
}