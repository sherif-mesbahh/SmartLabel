namespace SmartLabel.Application.Services;
public interface INotifierService
{
	public Task SendToUser(string userId, string message);

	public Task SendToGroup(string groupName, string message);
	public Task SendToAll(string message);
}