using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Handlers;
internal sealed class GetFavProductsPaginatedByUserHandler(IUserProductsProcRepository userFavProductRepository, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetFavProductsPaginatedByUserQuery, PagedList<GetAllProductsDto>>
{
	public async Task<PagedList<GetAllProductsDto>> Handle(GetFavProductsPaginatedByUserQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null)
			throw new KeyNotFoundException($"user ID: {userId} not found");

		(int totalCount, var getProducts) = await userFavProductRepository.GetUserProductsPaged(request, int.Parse(userId!));
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var products = PagedList<GetAllProductsDto>.CreateAsync(getProducts, totalCount, page, pageSize);
		return await products;
	}
}