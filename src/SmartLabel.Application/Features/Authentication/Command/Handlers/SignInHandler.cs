using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Features.Authentication.Results;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class SignInHandler(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager, IAuthenticationRepository authRepository) : ResponseHandler, IRequestHandler<SignInCommand, Response<AuthResponse>>
{
	public async Task<Response<AuthResponse>> Handle(SignInCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByEmailAsync(request.Email);
		if (user is null) return NotFound<AuthResponse>($"Email or Password is incorrect");
		var result = await signInManager.CheckPasswordSignInAsync(user, request.Password, true);
		if (!result.Succeeded) return BadRequest<AuthResponse>("Email or Password is incorrect");
		(string accessToken, string refreshToken) = await authRepository.GetJwtToken(user);
		await authRepository.SaveRefreshTokenAsync(user.Id, refreshToken);
		var authResponse = new AuthResponse()
		{
			AccessToken = accessToken,
			RefreshToken = refreshToken
		};
		return Success(authResponse);
	}
}
