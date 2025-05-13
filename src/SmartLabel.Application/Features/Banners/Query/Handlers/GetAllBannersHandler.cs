using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Repositories;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetAllBannersHandler(IBannerRepository repository, IMemoryCache memoryCache) : ResponseHandler, IRequestHandler<GetAllBannersQuery,
	Response<IEnumerable<GetBannersDto?>>>
{
	public async Task<Response<IEnumerable<GetBannersDto?>>> Handle(GetAllBannersQuery request, CancellationToken cancellationToken)
	{
		var cachedKey = $"Banners";
		if (memoryCache.TryGetValue(cachedKey, out IEnumerable<GetBannersDto?>? cachedResult))
		{
			return Success(cachedResult!, "All Banners retrieved successfully");
		}
		var cacheEntryOptions = new MemoryCacheEntryOptions()
			.SetSlidingExpiration(TimeSpan.FromMinutes(5))
			.SetAbsoluteExpiration(TimeSpan.FromHours(1))
			.SetPriority(CacheItemPriority.Normal);
		var banners = await repository.GetAllBannersAsync();
		memoryCache.Set(cachedKey, banners, cacheEntryOptions);
		return Success(banners, "All Banners retrieved successfully");
	}
}