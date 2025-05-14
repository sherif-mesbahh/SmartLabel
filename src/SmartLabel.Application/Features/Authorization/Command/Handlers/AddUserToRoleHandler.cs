using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authorization.Command.Handlers;

public class AddUserToRoleHandler(UserManager<ApplicationUser> userManager, IAuthorizationRepository authorizationRepository) : ResponseHandler, IRequestHandler<AddUserToRoleCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddUserToRoleCommand request, CancellationToken cancellationToken)
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

		var result = await authorizationRepository.AddUserToRoleAsync(existingUser, request.RoleName);
		if (!result.Succeeded)
		{
			var errors = result.Errors.Select(e => e.Description).ToList();

			return BadRequest<string>(
				message: "Add user to this role failed",
				errors: errors);
		}

		return Created<string>($"User with email {request.Email} became {request.RoleName}");
	}
}
