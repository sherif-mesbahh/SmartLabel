using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Shared.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class UpdateUserHandler(IMapper mapper, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<UpdateUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var userDb = await userManager.FindByIdAsync(userId!);
		if (userDb is null)
			return NotFound<string>($"The user is not found");
		var user = mapper.Map(request, userDb);
		var result = await userManager.UpdateAsync(user);
		if (!result.Succeeded)
			return BadRequest<string>(result.Errors.FirstOrDefault().Description);

		return Updated<string>("User is updated successfully");
	}
}
