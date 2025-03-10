using Microsoft.AspNetCore.Http;

namespace SmartLabel.Application.Features.Products.Command.Results;
public class AddProductResult
{
	public int Id { get; set; }
	public string Name { get; set; } = null!;
	public decimal OldPrice { get; set; }
	public int Discount { get; set; }
	public string? Description { get; set; }
	public int CatId { get; set; }
	public List<IFormFile>? ImagesFiles { get; set; }
}

