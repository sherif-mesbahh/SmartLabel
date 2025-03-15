namespace SmartLabel.Application.Features.Banners.Query.Results
{
	public class GetBannerResult
	{
		public int Id { get; set; }
		public string Title { get; set; }
		public GetBannerImageResult? Image { get; set; }
	}
}
