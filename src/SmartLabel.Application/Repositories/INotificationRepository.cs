namespace SmartLabel.Application.Repositories;
public interface INotificationRepository
{
	Task AddNotificationToUsers(string? message, IEnumerable<int> userIds);
}