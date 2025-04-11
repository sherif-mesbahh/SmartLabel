namespace SmartLabel.Application.Features.Products.Query.Results;

public class GetProductByIdDto
{
	public int Id { get; set; }
	public string Name { get; set; }
	public decimal OldPrice { get; set; }
	public int Discount { get; set; }
	public decimal NewPrice { get; set; }
	public string? Description { get; set; }
	public required string CategoryName { get; set; }
	public List<string>? Images { get; set; }
}