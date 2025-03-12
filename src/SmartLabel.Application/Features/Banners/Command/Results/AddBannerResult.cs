namespace SmartLabel.Application.Features.Banners.Command.Results
{
	public class AddBannerResult
	{
		public int Id { get; set; }
		public string Title { get; set; }
		public string? Description { get; set; }
		public DateTime StartDate { get; set; }
		public DateTime EndDate { get; set; }
		public ICollection<int> ProductIds { get; set; }
	}
}
