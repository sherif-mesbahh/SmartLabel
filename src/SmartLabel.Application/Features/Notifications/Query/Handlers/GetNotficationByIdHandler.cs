using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Notifications.Query.Models;
using SmartLabel.Application.Features.Notifications.Query.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Notifications.Query.Handlers;
public class GetNotficationByIdHandler(INotificationRepository notificationRepository) : ResponseHandler, IRequestHandler<GetNotificationByIdCommand, Response<GetNotificationByIdDto>>
{
	public async Task<Response<GetNotificationByIdDto>> Handle(GetNotificationByIdCommand request, CancellationToken cancellationToken)
	{
		var notfication = await notificationRepository.GetNotificationByIdAsync(request.Id);
		if (notfication == null)
			return NotFound<GetNotificationByIdDto>([$"Notfication with id {request.Id} is not found"], "Notfication not found");
		return Success(notfication, "Notfication retrieved successfully");
	}
}
