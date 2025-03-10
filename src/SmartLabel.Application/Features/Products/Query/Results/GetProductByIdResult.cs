using SmartLabel.Application.Features.ProductImages.Query.Results;

namespace SmartLabel.Application.Features.Products.Query.Results
{
	public class GetProductByIdResult
	{
		public int Id { get; set; }
		public string Name { get; set; } = null!;
		public decimal OldPrice { get; set; }
		public int Discount { get; set; }
		public decimal NewPrice { get; set; }
		public string? Description { get; set; }
		public int CatId { get; set; }
		public ICollection<GetProductImage>? Images { get; set; }
	}
}
