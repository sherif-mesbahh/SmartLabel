using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class EnterCodeToResetHandler(UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<EnterCodeToResetCommand, Response<string>>
{
	public async Task<Response<string>> Handle(EnterCodeToResetCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByEmailAsync(request.Email);
		if (user is null)
			return NotFound<string>(["Email is not found"], "Invalid data");

		if (user.Code != request.Code)
		{
			return BadRequest<string>(
				message: "Invalid data",
				errors: ["Code is wrong"]);
		}
		return Success("Code is correct");
	}
}