namespace SmartLabel.Application.Bases;
public class PagedList<T>(List<T>? items, int page, int pageSize, int totalCount)
{
	public int Page { get; set; } = page;
	public int PageSize { get; set; } = pageSize;
	public int TotalCount { get; set; } = totalCount;
	public bool HasPreviousPage => Page > 1;
	public bool HasNextPage => Page * PageSize < TotalCount;
	public List<T>? Data { get; set; } = items;

	public static async Task<PagedList<T>> CreateAsync(IEnumerable<T> query, int totalCount, int page, int pageSize)
	{
		//var totalCount = await query.CountAsync();
		var items = query;
		return new(items.ToList(), page, pageSize, totalCount);
	}
}