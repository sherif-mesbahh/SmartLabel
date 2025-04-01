using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Query.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Authorization.Query.Handlers;
public class GetUserRolesHandler(IAuthorizationRepository authorizationRepository, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<GetUserRolesQuery, Response<IEnumerable<string>>>
{
	public async Task<Response<IEnumerable<string>>> Handle(GetUserRolesQuery request, CancellationToken cancellationToken)
	{
		var existingUser = await userManager.FindByEmailAsync(request.Email);
		if (existingUser is null)
		{
			return NotFound<IEnumerable<string>>(
				message: "User not found",
				errors: [$"User with email '{request.Email}' doesn't exist"]);

		}

		return Success(await authorizationRepository.GetUserRolesAsync(existingUser),
			"All user roles retrieved successfully");
	}
}
