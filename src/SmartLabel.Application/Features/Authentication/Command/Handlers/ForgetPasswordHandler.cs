using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class ForgetPasswordHandler(UserManager<ApplicationUser> userManager, IEmailService emailService) : ResponseHandler, IRequestHandler<ForgetPasswordCommand, Response<string>>
{
	public async Task<Response<string>> Handle(ForgetPasswordCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByEmailAsync(request.Email);
		if (user is null)
			return NotFound<string>(["Email is not found"], "Invalid data");

		var code = new Random().Next(0, 1000000).ToString("D6");
		user.Code = code;
		var result = await userManager.UpdateAsync(user);
		if (!result.Succeeded)
		{
			var errors = result.Errors.Select(e => e.Description).ToList();
			return BadRequest<string>(message: "User creation failed", errors: errors);
		}
		var message = $"Code to reset password: {code}";
		await emailService.Send(request.Email, "Reset your password", message);
		return Success("");
	}
}