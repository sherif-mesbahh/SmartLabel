using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Users.Command.Models;
public class DeleteUserCommand(int id) : IRequest<Response<string>>
{
	public int Id = id;
}