using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class LogoutHandler(IAuthenticationRepository authRepository) : ResponseHandler, IRequestHandler<LogoutCommand, Response<string>>
{
	public async Task<Response<string>> Handle(LogoutCommand request, CancellationToken cancellationToken)
	{
		await authRepository.Logout(request.RefreshToken);
		return Success("Logged out successfully.");
	}
}
