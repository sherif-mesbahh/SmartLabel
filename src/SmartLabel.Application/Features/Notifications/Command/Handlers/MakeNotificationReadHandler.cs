using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Notifications.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Notifications.Command.Handlers;
public class MakeNotificationReadHandler(IHttpContextAccessor httpContextAccessor, INotificationRepository notificationRepository) : ResponseHandler, IRequestHandler<MakeNotificationReadCommand, Response<string>>
{
	public async Task<Response<string>> Handle(MakeNotificationReadCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null)
			return Unauthorized<string>("Please login first");

		var notification = await notificationRepository.GetNotificationByIdAsync(request.Id);
		if (notification is null) return NotFound<string>(["Notification is not found"], "Invalid Data");
		if (!await notificationRepository.CheckNotificationReading(int.Parse(userId), request.Id))
			await notificationRepository.MakeRead(int.Parse(userId), request.Id);
		return Success<string>("Notification is read successfully");
	}
}