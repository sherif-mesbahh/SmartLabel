using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Features.Authentication.Command.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class RefreshTokenHandler(IAuthenticationRepository authRepository) : ResponseHandler, IRequestHandler<RefreshTokenCommand, Response<GetTokensDto>>
{
	public async Task<Response<GetTokensDto>> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
	{
		var tokens = await authRepository.RefreshTokenAsync(request.RefreshToken);
		return Success(tokens);
	}
}
