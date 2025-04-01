using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class DeleteUserHandler(UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor) : ResponseHandler, IRequestHandler<DeleteUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId == null)
			return Unauthorized<string>("Please login first");
		var user = await userManager.FindByIdAsync(userId);
		if (user is null)
		{
			return NotFound<string>(
				message: "User not found",
				errors: [$"User with ID {userId} does not exist"]);
		}

		var result = await userManager.DeleteAsync(user);
		if (!result.Succeeded)
		{
			var errors = result.Errors.Select(e => e.Description).ToList();
			return BadRequest<string>(
				message: "User deletion failed",
				errors: errors);
		}

		return NoContent<string>();
	}
}
