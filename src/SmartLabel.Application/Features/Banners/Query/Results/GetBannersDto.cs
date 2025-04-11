namespace SmartLabel.Application.Features.Banners.Query.Results;

public class GetBannersDto
{
	public int Id { get; set; }
	public required string Title { get; set; }
	public string? ImageUrl { get; set; }
}