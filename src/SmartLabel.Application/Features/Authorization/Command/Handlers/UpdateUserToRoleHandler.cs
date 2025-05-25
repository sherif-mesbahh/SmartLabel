using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authorization.Command.Handlers;
public class UpdateUserToRoleHandler(UserManager<ApplicationUser> userManager, IAuthorizationRepository authorizationRepository, INotifierService notifierService)
	: ResponseHandler, IRequestHandler<UpdateUserToRoleCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateUserToRoleCommand request, CancellationToken cancellationToken)
	{
		var existingUser = await userManager.FindByEmailAsync(request.Email);
		if (existingUser is null)
		{
			return NotFound<string>(
				message: "User not found",
				errors: [$"User with email '{request.Email}' doesn't exist"]);

		}
		if (!await authorizationRepository.IsRoleExistByName(request.RoleName))
			return NotFound<string>([$"Role with name {request.RoleName} not found"], "Role not exist");

		try
		{
			await authorizationRepository.UpdateUserToRoleAsync(existingUser, request.RoleName);
			await notifierService.SendToGroup($"user-{existingUser.Id.ToString()}",
				"User role updated. Re-login required to apply changes.");

			return NoContent<string>($"User with email {request.Email} became {request.RoleName}");

		}
		catch (Exception ex)
		{
			var errors = new List<string> { $"{ex.Message}" };
			return BadRequest<string>(
				message: "update user to this role failed", errors: errors);
		}

	}
}
