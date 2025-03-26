using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class ChangePasswordHandler(IAuthenticationRepository authenticationRepository, IMapper mapper, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<ChangePasswordCommand, Response<string>>
{
	public async Task<Response<string>> Handle(ChangePasswordCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var user = await userManager.FindByIdAsync(userId!);
		if (user is null)
			return NotFound<string>($"The User is not found");
		var result = await userManager.ChangePasswordAsync(user, request.CurrentPassword, request.NewPassword);
		if (!result.Succeeded) return BadRequest<string>(result.Errors.FirstOrDefault().Description);
		await authenticationRepository.Logout(int.Parse(userId!));
		return Updated<string>("Password is Updated successfully");
	}
}
