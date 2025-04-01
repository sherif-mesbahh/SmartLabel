namespace SmartLabel.Application.Features.Categories.Query.Results;

public class GetAllCategoriesDto
{
	public required string Name { get; set; }
	public string? ImageUrl { get; set; }
}