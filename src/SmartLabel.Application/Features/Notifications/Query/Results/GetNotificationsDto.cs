namespace SmartLabel.Application.Features.Notifications.Query.Results;
public class GetNotificationsDto
{
	public int Id { get; set; }
	public string? Message { get; set; }
	public DateTime CreatedAt { get; set; }
}