using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Notifications.Query.Results;

namespace SmartLabel.Application.Features.Notifications.Query.Models;
public class GetNotificationByIdQuery(int id) : IRequest<Response<GetNotificationByIdDto>>
{
	public int Id = id;
}