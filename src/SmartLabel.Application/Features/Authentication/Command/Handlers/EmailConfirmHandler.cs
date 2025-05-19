using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class EmailConfirmHandler(UserManager<ApplicationUser> userManager) : IRequestHandler<EmailConfirmCommand, bool>
{
	public async Task<bool> Handle(EmailConfirmCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByIdAsync(request.UserId.ToString());
		if (user is null) return false;
		var res = await userManager.ConfirmEmailAsync(user, request.Code);
		if (!res.Succeeded) return false;
		return true;
	}
}