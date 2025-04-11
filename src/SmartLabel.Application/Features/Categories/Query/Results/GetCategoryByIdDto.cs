
using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.Categories.Query.Results;

public class GetCategoryByIdDto
{
	public int Id { get; set; }
	public required string Name { get; set; }
	public string? ImageUrl { get; set; }
	public List<GetAllProductsDto>? Products { get; set; }
}