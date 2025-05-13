using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Handlers;
public class GetFavProductsByUserHandler(IUserFavProductRepository userFavProductRepository, UserManager<ApplicationUser> userManager,
	IMemoryCache memoryCache, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetFavProductsByUserQuery, Response<IEnumerable<GetAllProductsDto>>>
{
	public async Task<Response<IEnumerable<GetAllProductsDto>>> Handle(GetFavProductsByUserQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var user = await userManager.FindByIdAsync(userId!);
		if (user is null)
			return NotFound<IEnumerable<GetAllProductsDto>>([$"user ID: {userId} not found"], "user discontinued");
		var cachedKey = $"ProductsFav-{userId}";
		if (memoryCache.TryGetValue(cachedKey, out IEnumerable<GetAllProductsDto>? cachedResult))
		{
			return Success(cachedResult!, "All Products retrieved successfully");
		}
		var cacheEntryOptions = new MemoryCacheEntryOptions()
			.SetSlidingExpiration(TimeSpan.FromMinutes(5))
			.SetAbsoluteExpiration(TimeSpan.FromHours(1))
			.SetPriority(CacheItemPriority.Normal);

		var favoriteProducts = await userFavProductRepository.GetFavProductsByUserAsync(user.Id);
		memoryCache.Set(cachedKey, favoriteProducts, cacheEntryOptions);
		return Success(favoriteProducts, "All Products retrieved successfully");
	}
}
