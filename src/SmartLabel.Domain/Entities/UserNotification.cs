using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Domain.Entities;
public class UserNotification
{
	public int Id { get; set; }
	public bool IsRead { get; set; }
	public int UserId { get; set; }
	public ApplicationUser User { get; set; }
	public int NotificationId { get; set; }
	public Notification Notification { get; set; }
}
