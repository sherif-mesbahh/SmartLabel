using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Results;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class RefreshTokenCommand : IRequest<Response<GetTokensDto>>
{
	public string RefreshToken { get; set; }
}