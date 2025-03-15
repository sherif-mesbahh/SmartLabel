namespace SmartLabel.Domain.Entities
{
	public class BannerImage
	{
		public int Id { get; set; }
		public string? ImageUrl { get; set; }
		public int BannerId { get; set; }
		public Banner Banner { get; set; }
	}
}
