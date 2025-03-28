namespace SmartLabel.Domain.Shared.Results.Banners;
public class GetBannersDto
{
	public required string Title { get; set; }
	public string? ImageUrl { get; set; }
}
