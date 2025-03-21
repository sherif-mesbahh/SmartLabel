using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class SignInHandler(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager, IAuthenticationRepository authRepository) : ResponseHandler, IRequestHandler<SignInCommand, Response<string>>
{
	public async Task<Response<string>> Handle(SignInCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByEmailAsync(request.Email);
		if (user is null) return NotFound<string>($"Email is incorrect");
		var result = await signInManager.CheckPasswordSignInAsync(user, request.Password, true);
		if (!result.Succeeded) return BadRequest<string>("Email or Password is incorrect");
		return Success<string>(await authRepository.GetJwtToken(user));
	}
}
