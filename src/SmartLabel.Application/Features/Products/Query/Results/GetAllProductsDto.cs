namespace SmartLabel.Application.Features.Products.Query.Results;

public class GetAllProductsDto
{
	public int Id { get; set; }
	public string? Name { get; set; }
	public decimal OldPrice { get; set; }
	public int Discount { get; set; }
	public decimal NewPrice { get; set; }
	public required string CategoryName { get; set; }
	public string? ImageUrl { get; set; }
}