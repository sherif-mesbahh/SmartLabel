namespace SmartLabel.Application.Features.Banners.Query.Results;
public class GetBannersToActiveOrNotDto
{
	public int Id { get; set; }
	public DateTime StartDate { get; set; }
	public DateTime EndDate { get; set; }
	public bool IsActive { get; set; }
}