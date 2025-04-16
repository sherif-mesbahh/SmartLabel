using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Results;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class SignInCommand : IRequest<Response<GetTokensDto>>
{
	public string Email { get; set; }
	public string Password { get; set; }
}