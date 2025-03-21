using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class SignInCommand : IRequest<Response<string>>
{
	public string Email { get; set; }
	public string Password { get; set; }
}