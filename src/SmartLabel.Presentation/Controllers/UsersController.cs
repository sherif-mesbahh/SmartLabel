using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Route("api")]
[ApiController]
public class UsersController(ISender sender) : AppControllerBase
{
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpGet("admin")]
	public async Task<IActionResult> GetAllUsers()
	{
		return NewResult(await sender.Send(new GetAllUsersQuery()));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet("me")]
	public async Task<IActionResult> GetUser()
	{
		return NewResult(await sender.Send(new GetUserQuery()));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpPut("me")]
	public async Task<IActionResult> UpdateUser(UpdateUserCommand user)
	{
		return NewResult(await sender.Send(user));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpPut("me/password")]
	public async Task<IActionResult> ChangePassword(ChangePasswordCommand request)
	{
		return NewResult(await sender.Send(request));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpDelete("me")]
	public async Task<IActionResult> DeleteUser()
	{
		return NewResult(await sender.Send(new DeleteUserCommand()));
	}
}