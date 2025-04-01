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
public class UserController(IMediator mediator) : AppControllerBase
{
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpGet]
	public async Task<IActionResult> GetAllUsers()
	{
		return NewResult(await mediator.Send(new GetAllUsersQuery()));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetUserById(int id)
	{
		return NewResult(await mediator.Send(new GetUserByIdQuery(id)));
	}

	[HttpPost]
	public async Task<IActionResult> Register(AddUserCommand user)
	{
		return NewResult(await mediator.Send(user));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpPut]
	public async Task<IActionResult> UpdateUser(UpdateUserCommand user)
	{
		return NewResult(await mediator.Send(user));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpPut("change-password")]
	public async Task<IActionResult> ChangePassword(ChangePasswordCommand changes)
	{
		return NewResult(await mediator.Send(changes));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpDelete]
	public async Task<IActionResult> DeleteUser()
	{
		return NewResult(await mediator.Send(new DeleteUserCommand()));
	}
}