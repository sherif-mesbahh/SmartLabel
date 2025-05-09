namespace SmartLabel.Application.Features.Notifications.Query.Results;
public class NotificationDto
{
	public int Id { get; set; }
	public string? Message { get; set; }
	public DateTime CreatedAt { get; set; }
}