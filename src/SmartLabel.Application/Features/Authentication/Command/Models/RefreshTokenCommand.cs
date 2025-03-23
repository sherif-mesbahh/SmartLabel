using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Results;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class RefreshTokenCommand : IRequest<Response<AuthResponse>>
{
	public string AccessToken { get; set; }
	public string RefreshToken { get; set; }

}