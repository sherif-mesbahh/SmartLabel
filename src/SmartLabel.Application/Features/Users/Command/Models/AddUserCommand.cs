using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Users.Command.Models;
public class AddUserCommand : IRequest<Response<string>>
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public string Email { get; set; }
	public string Password { get; set; }
	public string UserName { get; set; }
	public string ConfirmPassword { get; set; }
}
