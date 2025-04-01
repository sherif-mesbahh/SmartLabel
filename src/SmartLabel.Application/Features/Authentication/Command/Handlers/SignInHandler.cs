using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Features.Authentication.Command.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class SignInHandler(UserManager<ApplicationUser> userManager, IAuthenticationRepository authRepository) : ResponseHandler, IRequestHandler<SignInCommand, Response<GetTokensDto>>
{
	public async Task<Response<GetTokensDto>> Handle(SignInCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByEmailAsync(request.Email);
		if (user is null || !await userManager.CheckPasswordAsync(user, request.Password))
			return BadRequest<GetTokensDto>(["Email or password incorrect"], "Invalid request data");
		var authResponse = await authRepository.GetJwtTokenAsync(user);
		return Success(authResponse);
	}
}
