using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;
public class GetAllCategoryHandler(ICategoryRepository categoryRepository, IMemoryCache memoryCache) : ResponseHandler
	, IRequestHandler<GetAllCategoryQuery, Response<IEnumerable<GetAllCategoriesDto?>>>
{
	public async Task<Response<IEnumerable<GetAllCategoriesDto?>>> Handle(GetAllCategoryQuery request, CancellationToken cancellationToken)
	{
		var cachedKey = $"Categories";
		if (memoryCache.TryGetValue(cachedKey, out IEnumerable<GetAllCategoriesDto?>? cachedResult))
		{
			return Success(cachedResult!, "All categories retrieved successfully");

		}
		var cacheEntryOptions = new MemoryCacheEntryOptions()
			.SetSlidingExpiration(TimeSpan.FromMinutes(5))
			.SetAbsoluteExpiration(TimeSpan.FromHours(1))
			.SetPriority(CacheItemPriority.Normal);

		var categories = await categoryRepository.GetAllCategoriesAsync();
		memoryCache.Set(cachedKey, categories, cacheEntryOptions);
		return Success(categories, "All categories retrieved successfully");
	}
}

