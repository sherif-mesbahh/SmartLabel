namespace SmartLabel.Application.Features.Banners.Query.Results;
public class GetBannerByIdResult
{
	public int Id { get; set; }
	public string Title { get; set; }
	public string? Description { get; set; }
	public DateTime StartDate { get; set; }
	public DateTime EndDate { get; set; }
	public ICollection<GetBannerImageResult>? Images { get; set; }
}