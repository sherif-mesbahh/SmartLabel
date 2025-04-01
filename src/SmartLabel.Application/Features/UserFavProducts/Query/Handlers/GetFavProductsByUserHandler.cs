using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;
using UserFavProductDto = SmartLabel.Application.Features.UserFavProducts.Query.Results.UserFavProductDto;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Handlers;
public class GetFavProductsByUserHandler(IUserFavProductRepository userFavProductRepository, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetFavProductsByUserQuery, Response<IEnumerable<UserFavProductDto>>>
{
	public async Task<Response<IEnumerable<UserFavProductDto>>> Handle(GetFavProductsByUserQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var user = await userManager.FindByIdAsync(userId!);
		if (user is null)
			return NotFound<IEnumerable<UserFavProductDto>>([$"user ID: {userId} not found"], "user discontinued");
		var favoriteProducts = await userFavProductRepository.GetFavProductsByUserAsync(user.Id);
		return Success(favoriteProducts, "All Products retrieved successfully");
	}
}
