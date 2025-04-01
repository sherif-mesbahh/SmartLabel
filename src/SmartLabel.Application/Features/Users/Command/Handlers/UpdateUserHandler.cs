using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class UpdateUserHandler(IMapper mapper, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<UpdateUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId == null)
			return Unauthorized<string>("Please login first");
		var existingUser = await userManager.FindByIdAsync(userId);
		if (existingUser is null)
		{
			return NotFound<string>(
				message: "User not found",
				errors: [$"User with ID {userId} does not exist"]);
		}
		var user = mapper.Map(request, existingUser);
		var result = await userManager.UpdateAsync(user);
		if (!result.Succeeded)
		{
			var errors = result.Errors.Select(e => e.Description).ToList();
			return BadRequest<string>(
				message: "User update failed",
				errors: errors);
		}

		return NoContent<string>();
	}
}
