using SmartLabel.Domain.Shared.Results.Products;

namespace SmartLabel.Domain.Shared.Results.Categories;
public class GetCategoryByIdDto
{
	public required string Name { get; set; }
	public string? ImageUrl { get; set; }
	public List<GetAllProductsDto>? Products { get; set; }
}