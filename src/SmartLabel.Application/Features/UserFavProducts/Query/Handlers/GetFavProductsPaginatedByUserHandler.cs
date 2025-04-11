using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Linq.Expressions;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Handlers;
internal sealed class GetFavProductsPaginatedByUserHandler(IUserFavProductRepository userFavProductRepository, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetFavProductsPaginatedByUserQuery, PagedList<GetAllProductsDto>>
{
	public async Task<PagedList<GetAllProductsDto>> Handle(GetFavProductsPaginatedByUserQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var user = await userManager.FindByIdAsync(userId!);
		if (user is null)
			throw new KeyNotFoundException($"user ID: {userId} not found");
		var productsQuery = userFavProductRepository.GetFavProductsByUserQueryable(int.Parse(userId!));
		if (!string.IsNullOrEmpty(request.Search))
		{
			productsQuery = productsQuery
				.Where(x => x!.Name!.ToLower().Contains(request.Search.ToLower()));

		}

		var keySelector = GetSortProperty(request.SortColumn);
		if (!string.IsNullOrEmpty(request.SortOrder))
			productsQuery = request.SortOrder?.ToLower() == "desc" ? productsQuery.OrderByDescending(keySelector) : productsQuery.OrderBy(keySelector);

		var productResponseQuery = productsQuery;
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.Page == 0 ? 1 : request.Page);
		var products = PagedList<GetAllProductsDto>.CreateAsync(productResponseQuery, page, pageSize);
		return await products;
	}
	private static Expression<Func<GetAllProductsDto, object>> GetSortProperty(string? sortColumn) =>
		sortColumn?.ToLower() switch
		{
			"name" => product => product.Name!,
			"old-price" => product => product.OldPrice,
			"new-price" => product => product.NewPrice,
			"category-name" => product => product.CategoryName,
			"discount" => product => product.Discount,
			_ => product => product.Id
		};
}