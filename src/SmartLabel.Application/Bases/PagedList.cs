using Microsoft.EntityFrameworkCore;

namespace SmartLabel.Application.Bases;
public class PagedList<T>(List<T>? items, int page, int pageSize, int totalCount)
{
	public List<T>? Data { get; set; } = items;
	public int Page { get; set; } = page;
	public int PageSize { get; set; } = pageSize;
	public int TotalCount { get; set; } = totalCount;
	public bool HasPreviousPage => Page > 1;
	public bool HasNextPage => Page * PageSize < TotalCount;

	public static async Task<PagedList<T>> CreateAsync(IQueryable<T> query, int page, int pageSize)
	{
		var totalCount = await query.CountAsync();
		var items = await query
			.Skip((page - 1) * pageSize)
			.Take(pageSize)
			.ToListAsync();
		return new(items, page, pageSize, totalCount);
	}
}