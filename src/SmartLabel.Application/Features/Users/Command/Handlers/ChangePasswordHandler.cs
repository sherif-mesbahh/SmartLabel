using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class ChangePasswordHandler(IAuthenticationRepository authenticationRepository, IMapper mapper, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<ChangePasswordCommand, Response<string>>
{
	public async Task<Response<string>> Handle(ChangePasswordCommand request, CancellationToken cancellationToken)
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
		var result = await userManager.ChangePasswordAsync(user, request.CurrentPassword, request.NewPassword);
		if (!result.Succeeded)
		{
			var errors = result.Errors.Select(e => e.Description).ToList();
			return BadRequest<string>(
				message: "Password change failed",
				errors: errors);
		}
		await authenticationRepository.RevokeRefreshTokenAsync(int.Parse(userId));
		return NoContent<string>();
	}
}
