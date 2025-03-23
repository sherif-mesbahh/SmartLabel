using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Features.Authentication.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class RefreshTokenHandler(IAuthenticationRepository authRepository) : ResponseHandler, IRequestHandler<RefreshTokenCommand, Response<AuthResponse>>
{
	public async Task<Response<AuthResponse>> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
	{
		(string newAccessToken, string refreshToken) = await authRepository.RefreshToken(request.AccessToken, request.RefreshToken);
		var authResponse = new AuthResponse()
		{
			AccessToken = newAccessToken,
			RefreshToken = refreshToken
		};
		return Success(authResponse);
	}
}
