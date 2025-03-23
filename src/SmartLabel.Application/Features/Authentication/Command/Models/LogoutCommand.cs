using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class LogoutCommand : IRequest<Response<string>>
{
	public string RefreshToken { get; set; }
}