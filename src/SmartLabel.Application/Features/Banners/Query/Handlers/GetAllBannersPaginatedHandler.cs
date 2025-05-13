using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;

internal sealed class GetAllBannersPaginatedHandler(IBannerProcRepository bannerRepository, IMemoryCache memoryCache) :
	IRequestHandler<GetAllBannersPaginatedQuery, PagedList<GetBannersDto>>
{
	public async Task<PagedList<GetBannersDto>> Handle(GetAllBannersPaginatedQuery request, CancellationToken cancellationToken)
	{
		(int totalCount, var ban) = await bannerRepository.GetAllBannersPaged(request);
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var banners = await PagedList<GetBannersDto>.CreateAsync(ban, totalCount, page, pageSize);
		return banners;
	}
}