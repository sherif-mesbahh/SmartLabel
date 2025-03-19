namespace SmartLabel.Application.Features.Categories.Query.Results;

public class GetAllCategoryResult
{
	public int Id { get; set; }
	public string Name { get; set; } = null!;
	public string? ImageUrl { get; set; }
}
