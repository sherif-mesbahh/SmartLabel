using Microsoft.AspNetCore.SignalR;
using SmartLabel.Application.Services;
using SmartLabel.Infrastructure.Hubs;

namespace SmartLabel.Infrastructure.Services;
public class NotifierService(IHubContext<NotificationHub> hubContext) : INotifierService
{
	public async Task SendToUser(string userId, string message)
	{
		await hubContext.Clients.User(userId).SendAsync("ReceiveNotification", message);
	}

	public async Task SendToGroup(string groupName, string message)
	{
		await hubContext.Clients.Group(groupName).SendAsync("ReceiveNotification", message);
	}
	public async Task SendToAll(string message)
	{
		await hubContext.Clients.All.SendAsync("ReceiveNotification", message);
	}
}