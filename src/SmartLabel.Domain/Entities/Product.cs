namespace SmartLabel.Domain.Entities
{
	public class Product
	{
		public int Id { get; set; }
		public string Name { get; set; } = null!;
		public decimal OldPrice { get; set; }
		public int Discount { get; set; }
		public decimal NewPrice { get; set; }
		public string? Description { get; set; }
		public List<ProductImage>? Images { get; set; } = new List<ProductImage>();
		public int CatId { get; set; }
		public Category Category { get; set; }
	}
}
