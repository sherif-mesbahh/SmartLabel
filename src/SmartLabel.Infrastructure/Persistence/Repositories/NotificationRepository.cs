using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class NotificationRepository(AppDbContext context) : INotificationRepository
{
	private async Task AddNotificationAsync(Notification notification)
	{
		await context.Notifications.AddAsync(notification);
	}

	public async Task AddNotificationToUsers(string message, IEnumerable<int> userIds)
	{
		var notification = new Notification() { Id = 0, Message = message, CreatedAt = DateTime.UtcNow };
		await AddNotificationAsync(notification);
		await context.SaveChangesAsync();
		List<UserNotification> userNotifications = new();
		foreach (var userId in userIds)
		{
			userNotifications.Add(new UserNotification
			{ Id = 0, UserId = userId, NotificationId = notification.Id });
		}

		await context.AddRangeAsync(userNotifications);
	}
}