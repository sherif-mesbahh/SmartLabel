﻿using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Route("api/[controller]")]
[ApiController]
public class UserController(IMediator mediator) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllUsers()
	{
		return NewResult(await mediator.Send(new GetAllUsersQuery()));
	}
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetUserById(int id)
	{
		return NewResult(await mediator.Send(new GetUserByIdQuery(id)));
	}
	[HttpPost]
	public async Task<IActionResult> AddUser(AddUserCommand user)
	{
		return NewResult(await mediator.Send(user));
	}

	[HttpPut]
	public async Task<IActionResult> UpdateUser(UpdateUserCommand user)
	{
		return NewResult(await mediator.Send(user));
	}

	[HttpPut("ChangePassword")]
	public async Task<IActionResult> ChangePassword(ChangePasswordCommand changes)
	{
		return NewResult(await mediator.Send(changes));
	}

	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteUser(int id)
	{
		return NewResult(await mediator.Send(new DeleteUserCommand(id)));
	}
}