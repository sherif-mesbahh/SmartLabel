using Dapper;
using SmartLabel.Application.Features.Notifications.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class NotificationRepository(AppDbContext context, ISqlConnectionFactory sqlConnectionFactory) : INotificationRepository
{
	private async Task AddNotificationAsync(Notification notification)
	{
		await context.Notifications.AddAsync(notification);
	}

	public async Task AddNotificationToUsers(string message, IEnumerable<int> userIds)
	{
		var notification = new Notification { Id = 0, Message = message, CreatedAt = DateTime.UtcNow };
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

	public async Task<IEnumerable<NotificationDto>> GetNotificationsAsync(int userId)
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT n.Id AS Id, n.Message AS Message, n.CreatedAt AS CreatedAt
		               FROM Notifications n
		               INNER JOIN UserNotifications u
		               ON n.Id = u.NotificationId
		               WHERE u.UserId = @UserId
		               """;
		var notifications = await connection.QueryAsync<NotificationDto>(sqlQuery, new { UserId = userId });
		return notifications;
	}
}