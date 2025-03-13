namespace SmartLabel.Application.Features.Banners.Query.Results
{
	public class GetBannerResult
	{
		public int Id { get; set; }
		public string Title { get; set; }
		public string? Description { get; set; }
		public DateTime StartDate { get; set; }
		public DateTime EndDate { get; set; }
	}
}
