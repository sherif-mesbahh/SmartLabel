using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Products.Query.Handlers;
public class GetAllProductsHandler(IProductRepository repository, IHttpContextAccessor httpContextAccessor, IMemoryCache memoryCache)
	: ResponseHandler, IRequestHandler<GetAllProductsQuery, Response<IEnumerable<GetAllProductsDto?>>>
{
	public async Task<Response<IEnumerable<GetAllProductsDto?>>> Handle(GetAllProductsQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var cachedKey = $"ProductsUserId-{userId}";
		if (memoryCache.TryGetValue(cachedKey, out IEnumerable<GetAllProductsDto?>? cachedResult))
		{
			return Success(cachedResult!, "All Products are retrieved successfully");
		}
		//ToDo : when add product and delete from user favorite remove from cache
		var cacheEntryOptions = new MemoryCacheEntryOptions()
			.SetSlidingExpiration(TimeSpan.FromMinutes(5))
			.SetAbsoluteExpiration(TimeSpan.FromHours(1))
			.SetPriority(CacheItemPriority.Normal);
		var products = await repository.GetAllProductsAsync(userId);
		memoryCache.Set(cachedKey, products, cacheEntryOptions);
		return Success(products!, "All Products are retrieved successfully");
	}
}
