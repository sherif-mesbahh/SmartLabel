using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.Categories.Query.Results;
public class GetCategoryResultById
{
	public int Id { get; set; }
	public string Name { get; set; } = null!;
	public string? ImageUrl { get; set; }
	public ICollection<GetAllProductsResult>? Products { get; set; }
}