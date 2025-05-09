using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Notifications.Query.Models;
using SmartLabel.Application.Features.Notifications.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Notifications.Query.Handlers;
public class GetNotificationsHandler(INotificationRepository notificationRepository, IHttpContextAccessor httpContextAccessor) : ResponseHandler,
	IRequestHandler<GetNotificationsCommand, Response<IEnumerable<NotificationDto>>>
{
	public async Task<Response<IEnumerable<NotificationDto>>> Handle(GetNotificationsCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null)
			return Unauthorized<IEnumerable<NotificationDto>>("Please login first");
		var notifications = await notificationRepository.GetNotificationsAsync(int.Parse(userId));
		return Success(notifications, "Notifications are retrieved successfully");
	}
}

