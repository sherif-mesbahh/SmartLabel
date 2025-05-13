using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Repositories;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetActiveBannersHandler(IBannerRepository repository, IMemoryCache memoryCache) : ResponseHandler,
	IRequestHandler<GetActiveBannersQuery, Response<IEnumerable<GetBannersDto?>>>
{
	public async Task<Response<IEnumerable<GetBannersDto?>>> Handle(GetActiveBannersQuery request, CancellationToken cancellationToken)
	{
		var cachedKey = $"ActiveBanners";
		if (memoryCache.TryGetValue(cachedKey, out IEnumerable<GetBannersDto?>? cachedResult))
		{
			return Success(cachedResult!, "Active banners retrieved successfully");
		}
		var cacheEntryOptions = new MemoryCacheEntryOptions()
			.SetSlidingExpiration(TimeSpan.FromMinutes(5))
			.SetAbsoluteExpiration(TimeSpan.FromHours(1))
			.SetPriority(CacheItemPriority.Normal);
		var activeBanners = await repository.GetActiveBannersAsync();
		memoryCache.Set(cachedKey, activeBanners, cacheEntryOptions);
		return Success(activeBanners, "Active banners retrieved successfully");
	}
}
