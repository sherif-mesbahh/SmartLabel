using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;

public class ResetPasswordHandle(UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<ResetPasswordCommand, Response<string>>
{
	public async Task<Response<string>> Handle(ResetPasswordCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByEmailAsync(request.Email);
		if (user is null)
			return NotFound<string>(["Email is not found"], "Invalid data");

		await userManager.RemovePasswordAsync(user);
		if (request.Password is not null)
			await userManager.AddPasswordAsync(user, request.Password);
		return Success("Your password is reseted successfully");
	}
}