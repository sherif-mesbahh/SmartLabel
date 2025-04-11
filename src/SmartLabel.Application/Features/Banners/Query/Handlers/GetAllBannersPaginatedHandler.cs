using MediatR;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using System.Linq.Expressions;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;

internal sealed class GetAllBannersPaginatedHandler(IBannerRepository bannerRepository) : IRequestHandler<GetAllBannersPaginatedQuery, PagedList<GetBannersDto>>
{
	public async Task<PagedList<GetBannersDto>> Handle(GetAllBannersPaginatedQuery request, CancellationToken cancellationToken)
	{
		var bannersQuery = bannerRepository.GetAllBannersPaginated();
		if (!string.IsNullOrEmpty(request.Search))
		{
			bannersQuery = bannersQuery
				.Where(x => x.Title.ToLower().Contains(request.Search.ToLower()));

		}

		var keySelector = GetSortProperty(request.SortColumn);
		if (!string.IsNullOrEmpty(request.SortOrder))
			bannersQuery = request.SortOrder?.ToLower() == "desc" ? bannersQuery.OrderByDescending(keySelector) : bannersQuery.OrderBy(keySelector);

		var bannerResponseQuery = bannersQuery
			.AsNoTracking()
			.Select(b => new GetBannersDto()
			{
				Id = b.Id,
				Title = b.Title,
				ImageUrl = b.Images.FirstOrDefault().ImageUrl
			});
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.Page == 0 ? 1 : request.Page);
		var banners = PagedList<GetBannersDto>.CreateAsync(bannerResponseQuery, page, pageSize);
		return await banners;
	}

	private static Expression<Func<Banner, object>> GetSortProperty(string? sortColumn) =>
		sortColumn?.ToLower() switch
		{
			"title" => banner => banner.Title,
			_ => banner => banner.Id
		};
}