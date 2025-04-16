using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Users.Command.Models;
public class UpdateUserCommand : IRequest<Response<string>>
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public string Email { get; set; }
}