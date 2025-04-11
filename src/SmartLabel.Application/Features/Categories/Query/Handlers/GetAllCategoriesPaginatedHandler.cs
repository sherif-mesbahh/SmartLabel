using MediatR;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using System.Linq.Expressions;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;

internal sealed class GetAllCategoriesPaginatedHandler(ICategoryRepository categoryRepository)
	: IRequestHandler<GetAllCategoriesPaginatedQuery, PagedList<GetAllCategoriesDto>>
{
	public async Task<PagedList<GetAllCategoriesDto>> Handle(GetAllCategoriesPaginatedQuery request,
		CancellationToken cancellationToken)
	{
		var categoryQuery = categoryRepository.GetAllCategoriesPaginated();
		if (!string.IsNullOrEmpty(request.Search))
		{
			categoryQuery = categoryQuery
				.Where(x => x.Name.ToLower().Contains(request.Search.ToLower()));

		}

		var keySelector = GetSortProperty(request.SortColumn);
		if (!string.IsNullOrEmpty(request.SortOrder))
			categoryQuery = request.SortOrder?.ToLower() == "desc"
				? categoryQuery.OrderByDescending(keySelector)
				: categoryQuery.OrderBy(keySelector);

		var categoryResponseQuery = categoryQuery
			.AsNoTracking()
			.Select(c => new GetAllCategoriesDto()
			{
				Id = c.Id,
				Name = c.Name,
				ImageUrl = c.ImageUrl
			});
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.Page == 0 ? 1 : request.Page);
		var categories = PagedList<GetAllCategoriesDto>.CreateAsync(categoryResponseQuery, page, pageSize);
		return await categories;
	}
	private static Expression<Func<Category, object>> GetSortProperty(string? sortColumn) =>
		sortColumn?.ToLower() switch
		{
			"name" => category => category.Name,
			_ => category => category.Id
		};
}