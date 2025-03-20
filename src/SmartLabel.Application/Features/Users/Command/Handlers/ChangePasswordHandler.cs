using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class ChangePasswordHandler(IMapper mapper, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<ChangePasswordCommand, Response<string>>
{
	public async Task<Response<string>> Handle(ChangePasswordCommand request, CancellationToken cancellationToken)
	{
		var user = await userManager.FindByIdAsync(request.Id.ToString());
		if (user is null) return NotFound<string>($"The user with id {request.Id} is not found");
		var result = await userManager.ChangePasswordAsync(user, request.CurrentPassword, request.NewPassword);
		if (!result.Succeeded) return BadRequest<string>(result.Errors.FirstOrDefault().Description);
		return Updated<string>("Password is Updated successfully");
	}
}
