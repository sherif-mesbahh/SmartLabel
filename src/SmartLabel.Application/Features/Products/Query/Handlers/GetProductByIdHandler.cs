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

public class GetProductByIdHandler(IProductRepository repository, IHttpContextAccessor httpContextAccessor, IMemoryCache memoryCache) : ResponseHandler, IRequestHandler<GetProductByIdQuery, Response<GetProductByIdDto>>
{
	public async Task<Response<GetProductByIdDto>> Handle(GetProductByIdQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var cachedKey = $"ProductId-{request.Id}UserId-{userId}";
		if (memoryCache.TryGetValue(cachedKey, out GetProductByIdDto? cachedResult))
		{
			return Success(cachedResult!, "product retrieved successfully");
		}
		var product = await repository.GetProductByIdUserAsync(request.Id, userId);
		//when update or delete favorite remove from cache
		if (product is null)
			throw new KeyNotFoundException("Product with ID " + request.Id + " not found");
		var cacheEntryOptions = new MemoryCacheEntryOptions()
			.SetSlidingExpiration(TimeSpan.FromMinutes(5))
			.SetAbsoluteExpiration(TimeSpan.FromHours(1))
			.SetPriority(CacheItemPriority.Normal);
		memoryCache.Set(cachedKey, product, cacheEntryOptions);
		return Success(product, "product retrieved successfully");
	}
}