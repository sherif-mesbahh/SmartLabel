using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authorization.Command.Handlers;
public class RemoveUserFromRoleHandler(IAuthorizationRepository authorizationRepository, UserManager<ApplicationUser> userManager) : ResponseHandler,
	IRequestHandler<RemoveUserFromRoleCommand, Response<string>>
{
	public async Task<Response<string>> Handle(RemoveUserFromRoleCommand request, CancellationToken cancellationToken)
	{
		var existingUser = await userManager.FindByEmailAsync(request.Email);
		if (existingUser is null)
		{
			return NotFound<string>(
				message: "User not found",
				errors: [$"User with email '{request.Email}' doesn't exist"]);

		}
		if (!await authorizationRepository.IsRoleExist(request.RoleName))
			return NotFound<string>([$"Role with name {request.RoleName} not found"], "Role not exist");

		if (!await userManager.IsInRoleAsync(existingUser, request.RoleName))
		{
			return BadRequest<string>(
				message: "delete user from this role failed",
				errors: [$"This user doesn't exist in this role {request.RoleName}"]);
		}

		try
		{
			await authorizationRepository.RemoveUserFromRoleAsync(existingUser, request.RoleName);
			return Created<string>($"User with email {request.Email} is no longer {request.RoleName}");
		}
		catch (Exception ex)
		{
			var errors = new List<string> { $"{ex.Message}" };

			return BadRequest<string>(
				message: "delete user from this role failed",
				errors: errors);
		}
	}
}
