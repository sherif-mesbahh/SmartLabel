using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Notifications.Command.Models;
public class MakeNotificationReadCommand(int id) : IRequest<Response<string>>
{
	public int Id = id;
}