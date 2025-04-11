using MediatR;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using System.Linq.Expressions;

namespace SmartLabel.Application.Features.Products.Query.Handlers;
internal sealed class GetAllProductsPaginatedHandler(IProductRepository productRepository) : ResponseHandler, IRequestHandler<GetAllProductsPaginatedQuery, PagedList<GetAllProductsDto>>
{
	public async Task<PagedList<GetAllProductsDto>> Handle(GetAllProductsPaginatedQuery request, CancellationToken cancellationToken)
	{
		var productsQuery = productRepository.GetAllProductsPaginated();
		if (!string.IsNullOrEmpty(request.Search))
		{
			productsQuery = productsQuery
			.Where(x => x.Name.ToLower().Contains(request.Search.ToLower()));

		}

		var keySelector = GetSortProperty(request.SortColumn);
		if (!string.IsNullOrEmpty(request.SortOrder))
			productsQuery = request.SortOrder?.ToLower() == "desc" ? productsQuery.OrderByDescending(keySelector) : productsQuery.OrderBy(keySelector);

		var productResponseQuery = productsQuery
			.AsNoTracking()
			.Select(p => new GetAllProductsDto()
			{
				Id = p.Id,
				Name = p.Name,
				CategoryName = p.Category.Name,
				Discount = p.Discount,
				OldPrice = p.OldPrice,
				NewPrice = p.NewPrice,
				ImageUrl = p.Images.FirstOrDefault().ImageUrl
			});
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.Page == 0 ? 1 : request.Page);
		var products = PagedList<GetAllProductsDto>.CreateAsync(productResponseQuery, page, pageSize);
		return await products;
	}

	private static Expression<Func<Product, object>> GetSortProperty(string? sortColumn) =>
		sortColumn?.ToLower() switch
		{
			"name" => product => product.Name,
			"old-price" => product => product.OldPrice,
			"new-price" => product => product.NewPrice,
			"category-name" => product => product.Category.Name,
			"discount" => product => product.Discount,
			_ => product => product.Id
		};
}