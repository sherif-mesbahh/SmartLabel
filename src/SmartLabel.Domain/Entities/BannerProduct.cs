namespace SmartLabel.Domain.Entities
{
	public class BannerProduct
	{
		public int Id { get; set; }
		public int BannerId { get; set; }
		public Banner Banner { get; set; }

		public int ProductId { get; set; }
		public Product Product { get; set; }
	}
}
