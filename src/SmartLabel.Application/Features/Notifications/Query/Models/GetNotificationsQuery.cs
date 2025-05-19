using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Notifications.Query.Results;

namespace SmartLabel.Application.Features.Notifications.Query.Models;
public class GetNotificationsQuery : IRequest<Response<IEnumerable<GetNotificationsDto>>>
{
}