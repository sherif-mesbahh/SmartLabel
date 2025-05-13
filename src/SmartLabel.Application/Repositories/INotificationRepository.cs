using SmartLabel.Application.Features.Notifications.Query.Results;

namespace SmartLabel.Application.Repositories;
public interface INotificationRepository
{
	Task AddNotificationToUsers(string? message, IEnumerable<int> userIds, int type, int typeId);
	Task<IEnumerable<GetNotificationsDto>> GetNotificationsAsync(int userId);
	Task<GetNotificationByIdDto?> GetNotificationByIdAsync(int id);
}