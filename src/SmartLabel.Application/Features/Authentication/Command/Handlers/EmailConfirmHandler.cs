using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class EmailConfirmHandler(UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<EmailConfirmCommand, Response<string>>
{
	public async Task<Response<string>> Handle(EmailConfirmCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByIdAsync(request.UserId.ToString());
		if (user is null)
			return BadRequest<string>(["user is not found"], "Invalid data");

		var res = await userManager.ConfirmEmailAsync(user, request.Code);
		if (!res.Succeeded)
		{
			// Include the actual errors in the response
			var errors = res.Errors.Select(e => e.Description).ToList();
			return BadRequest<string>(errors, "Email confirmation failed");
		}

		return Success<string>("Email confirmed successfully");

	}
}