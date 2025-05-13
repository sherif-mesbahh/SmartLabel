namespace SmartLabel.Domain.Entities;
public class Notification
{
	public int Id { get; set; }
	public string Message { get; set; }
	public int Type { get; set; }
	public int TypeId { get; set; }
	public DateTime CreatedAt { get; set; }
	public ICollection<UserNotification> UserNotifications { get; set; }
}