namespace SmartLabel.Application.Features.Banners.Query.Results;

public class GetBannersDto
{
	public required string Title { get; set; }
	public string? ImageUrl { get; set; }
}