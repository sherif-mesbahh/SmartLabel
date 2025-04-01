using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Features.Authorization.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Authorize(Roles = nameof(Roles.Admin))]
[Route("api/[controller]")]
[ApiController]
public class AuthorizationController(ISender sender) : AppControllerBase
{
	[HttpGet("roles")]
	public async Task<IActionResult> GetAllRoles()
	{
		return NewResult(await sender.Send(new GetAllRolesQuery()));
	}
	[HttpGet("user-roles/{email}")]
	public async Task<IActionResult> GetUserRoles(string email)
	{
		return NewResult(await sender.Send(new GetUserRolesQuery(email)));
	}
	[HttpPost("add-role/{name}")]
	public async Task<IActionResult> AddRole(string name)
	{
		var command = new AddRoleCommand { Name = name };
		return NewResult(await sender.Send(command));
	}
	[HttpPut("update-role")]
	public async Task<IActionResult> UpdateRole([FromBody] UpdateRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpDelete("delete-role/{name}")]
	public async Task<IActionResult> DeleteRole(string name)
	{
		var command = new DeleteRoleCommand { Name = name };
		return NewResult(await sender.Send(command));
	}
	[HttpDelete("take-role")]
	public async Task<IActionResult> AddUserToRole([FromBody] RemoveUserFromRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPost("assign-role")]
	public async Task<IActionResult> AddUserToRole([FromBody] AddUserToRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPut("update-user-role")]
	public async Task<IActionResult> UpdateUserToRole([FromBody] UpdateUserToRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
}
