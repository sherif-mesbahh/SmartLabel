namespace SmartLabel.Domain.Shared.Results.Products;
public class GetAllProductsDto
{
	public required string Name { get; set; }
	public decimal OldPrice { get; set; }
	public int Discount { get; set; }
	public decimal NewPrice { get; set; }
	public required string CategoryName { get; set; }
	public string? ImageUrl { get; set; }
}
