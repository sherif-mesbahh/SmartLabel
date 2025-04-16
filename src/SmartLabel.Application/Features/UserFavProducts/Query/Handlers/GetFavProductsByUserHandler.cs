using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Handlers;
public class GetFavProductsByUserHandler(IUserFavProductRepository userFavProductRepository, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetFavProductsByUserQuery, Response<IEnumerable<GetAllProductsDto>>>
{
	public async Task<Response<IEnumerable<GetAllProductsDto>>> Handle(GetFavProductsByUserQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var user = await userManager.FindByIdAsync(userId!);
		if (user is null)
			return NotFound<IEnumerable<GetAllProductsDto>>([$"user ID: {userId} not found"], "user discontinued");
		var favoriteProducts = await userFavProductRepository.GetFavProductsByUserAsync(user.Id);
		return Success(favoriteProducts, "All Products retrieved successfully");
	}
}
