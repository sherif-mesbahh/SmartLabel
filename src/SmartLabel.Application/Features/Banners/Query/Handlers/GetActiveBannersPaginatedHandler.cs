using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
internal sealed class GetActiveBannersPaginatedHandler(IBannerProcRepository bannerRepository) : IRequestHandler<GetActiveBannersPaginatedQuery, PagedList<GetBannersDto>>
{
	public async Task<PagedList<GetBannersDto>> Handle(GetActiveBannersPaginatedQuery request, CancellationToken cancellationToken)
	{
		(int totalCount, var activeBan) = await bannerRepository.GetActiveBannersPaged(request);
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var banners = PagedList<GetBannersDto>.CreateAsync(activeBan, totalCount, page, pageSize);
		return await banners;
	}
}