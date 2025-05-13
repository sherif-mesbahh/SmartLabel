namespace SmartLabel.Application.Features.Banners.Query.Results;

public class GetBannerByIdDto
{
	public int Id { get; set; }
	public string Title { get; set; }
	public string? Description { get; set; }
	public DateTime StartDate { get; set; }
	public DateTime EndDate { get; set; }
	public string? MainImage { get; set; }
	public List<GetBannerImageDto>? Images { get; set; }
}