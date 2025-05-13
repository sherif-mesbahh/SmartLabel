using Microsoft.AspNetCore.SignalR;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Infrastructure.Hubs;

public class NotificationHub : Hub
{
	public override async Task OnConnectedAsync()
	{
		var userId = Context.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is not null)
			await Groups.AddToGroupAsync(Context.ConnectionId, $"user-{userId}");
		await base.OnConnectedAsync();
	}

	public override async Task OnDisconnectedAsync(Exception? exception)
	{
		var userId = Context.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is not null)
			await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"user-{userId}");
		await base.OnDisconnectedAsync(exception);
	}
}