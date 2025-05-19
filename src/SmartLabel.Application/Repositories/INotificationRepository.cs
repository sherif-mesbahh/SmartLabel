using SmartLabel.Application.Features.Notifications.Query.Results;

namespace SmartLabel.Application.Repositories;
public interface INotificationRepository
{
	Task AddNotificationToUsers(string? message, IEnumerable<int> userIds, int type, int typeId, string image);
	Task<IEnumerable<GetNotificationsDto>> GetNotificationsAsync(int userId);
	Task<bool> CheckNotificationReading(int userId, int notificationId);
	Task<GetNotificationByIdDto?> GetNotificationByIdAsync(int id);
	Task MakeRead(int userId, int notificationId);
}