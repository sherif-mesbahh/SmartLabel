using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Repositories;
using GetBannerByIdDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannerByIdDto;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetBannerByIdHandler(IBannerRepository repository, IMemoryCache memoryCache) : ResponseHandler,
	IRequestHandler<GetBannerByIdQuery, Response<GetBannerByIdDto>>
{
	public async Task<Response<GetBannerByIdDto>> Handle(GetBannerByIdQuery request, CancellationToken cancellationToken)
	{

		var cachedKey = $"Banner-{request.Id}";
		if (memoryCache.TryGetValue(cachedKey, out GetBannerByIdDto? cachedResult))
		{
			return Success(cachedResult!, $"Banner {request.Id} retrieved successfully");
		}
		var cacheEntryOptions = new MemoryCacheEntryOptions()
			.SetSlidingExpiration(TimeSpan.FromMinutes(5))
			.SetAbsoluteExpiration(TimeSpan.FromHours(1))
			.SetPriority(CacheItemPriority.Normal);
		var banner = await repository.GetBannerByIdAsync(request.Id);
		if (banner is null)
			return NotFound<GetBannerByIdDto>([$"Banner ID: {request.Id} not found"], "Banner discontinued");
		memoryCache.Set(cachedKey, banner, cacheEntryOptions);
		return Success(banner, $"Banner {request.Id} retrieved successfully");
	}
}