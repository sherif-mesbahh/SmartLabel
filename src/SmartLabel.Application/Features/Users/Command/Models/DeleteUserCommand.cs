using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Users.Command.Models;
public class DeleteUserCommand : IRequest<Response<string>>
{
}