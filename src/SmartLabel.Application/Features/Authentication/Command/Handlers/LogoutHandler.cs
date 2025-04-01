using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Authentication.Command.Handlers;
public class LogoutHandler(IAuthenticationRepository authRepository, IHttpContextAccessor httpContextAccessor, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<LogoutCommand, Response<string>>
{
	public async Task<Response<string>> Handle(LogoutCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var user = await userManager.FindByIdAsync(userId!);
		if (user is null)
			return NotFound<string>([$"user ID: {userId} not found"], "user discontinued");
		await authRepository.RevokeRefreshTokenAsync(user.Id);
		return NoContent<string>("Logged out successfully.");
	}
}
