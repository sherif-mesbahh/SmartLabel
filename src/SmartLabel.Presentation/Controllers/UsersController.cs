using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Route("api/[controller]")]
[ApiController]
public class UsersController(ISender sender) : AppControllerBase
{
	[Authorize(Roles = nameof(RolesEnum.Admin))]
	[HttpGet("admin")]
	public async Task<IActionResult> GetAllUsers()
	{
		return NewResult(await sender.Send(new GetAllUsersQuery()));
	}
	[Authorize(Policy = nameof(RolesEnum.UserOrAdmin))]
	[HttpGet("me")]
	public async Task<IActionResult> GetUser()
	{
		return NewResult(await sender.Send(new GetUserQuery()));
	}
	[Authorize(Policy = nameof(RolesEnum.UserOrAdmin))]
	[HttpPut("me")]
	public async Task<IActionResult> UpdateUser(UpdateUserCommand user)
	{
		return NewResult(await sender.Send(user));
	}
	[Authorize(Policy = nameof(RolesEnum.UserOrAdmin))]
	[HttpPut("me/password")]
	public async Task<IActionResult> ChangePassword(ChangePasswordCommand request)
	{
		return NewResult(await sender.Send(request));
	}
	[Authorize(Policy = nameof(RolesEnum.UserOrAdmin))]
	[HttpDelete("me")]
	public async Task<IActionResult> DeleteUser()
	{
		return NewResult(await sender.Send(new DeleteUserCommand()));
	}
}