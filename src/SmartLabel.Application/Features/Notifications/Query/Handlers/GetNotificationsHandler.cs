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
	IRequestHandler<GetNotificationsQuery, Response<IEnumerable<GetNotificationsDto>>>
{
	public async Task<Response<IEnumerable<GetNotificationsDto>>> Handle(GetNotificationsQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null)
			return Unauthorized<IEnumerable<GetNotificationsDto>>("Please login first");
		var notifications = await notificationRepository.GetNotificationsAsync(int.Parse(userId));
		return Success(notifications, "Notifications are retrieved successfully");
	}
}

