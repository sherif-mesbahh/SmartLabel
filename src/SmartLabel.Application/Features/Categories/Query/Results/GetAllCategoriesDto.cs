namespace SmartLabel.Application.Features.Categories.Query.Results;

public class GetAllCategoriesDto
{
	public int Id { get; set; }
	public required string Name { get; set; }
	public string? ImageUrl { get; set; }
}