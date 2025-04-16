using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Domain.Entities;
using System.Linq.Expressions;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;

internal sealed class GetAllBannersPaginatedHandler(IBannerProcRepository bannerRepository) : IRequestHandler<GetAllBannersPaginatedQuery, PagedList<GetBannersDto>>
{
	public async Task<PagedList<GetBannersDto>> Handle(GetAllBannersPaginatedQuery request, CancellationToken cancellationToken)
	{
		(int totalCount, var ban) = await bannerRepository.GetAllBannersPaged(request);
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var banners = PagedList<GetBannersDto>.CreateAsync(ban, totalCount, page, pageSize);
		return await banners;
	}

	private static Expression<Func<Banner, object>> GetSortProperty(string? sortColumn) =>
		sortColumn?.ToLower() switch
		{
			"title" => banner => banner.Title,
			_ => banner => banner.Id
		};
}