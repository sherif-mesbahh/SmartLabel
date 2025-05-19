using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Features.Authentication.Command.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class SignInHandler(UserManager<ApplicationUser> userManager, IAuthenticationRepository authRepository, IEmailService emailService) : ResponseHandler, IRequestHandler<SignInCommand, Response<GetTokensDto>>
{
	public async Task<Response<GetTokensDto>> Handle(SignInCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByEmailAsync(request.Email);
		if (user is null || !await userManager.CheckPasswordAsync(user, request.Password))
			return NotFound<GetTokensDto>(["Email or password incorrect"], "Invalid request data");
		if (!user.EmailConfirmed)
		{
			var code = await userManager.GenerateEmailConfirmationTokenAsync(user);
			var url = emailService.PrepareUrl(user.Id, code);
			await emailService.Send(user.Email, "Confirm your email - Required for Login", url, "email-confirmed.html");
			return BadRequest<GetTokensDto>(["Email is not confirmed"], "You must confirm your email to log in." +
				" A new confirmation link has been sent to your email address.");
		}
		var authResponse = await authRepository.GetJwtTokenAsync(user);
		return Success(authResponse);
	}
}
