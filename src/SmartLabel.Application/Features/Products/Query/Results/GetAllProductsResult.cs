
namespace SmartLabel.Application.Features.Products.Query.Results
{
	public class GetAllProductsResult
	{
		public int Id { get; set; }
		public string Name { get; set; } = null!;
		public decimal OldPrice { get; set; }
		public int Discount { get; set; }
		public decimal NewPrice { get; set; }
		public string? CategoryName { get; set; }
		public GetProductImageResult? Image { get; set; }
	}
}
