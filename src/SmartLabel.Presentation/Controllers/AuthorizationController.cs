using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Features.Authorization.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Authorize(Roles = nameof(RolesEnum.Admin))]
[Route("api/[controller]")]
[ApiController]
public class AuthorizationController(ISender sender) : AppControllerBase
{
	[HttpGet("roles")]
	public async Task<IActionResult> GetAllRoles()
	{
		return NewResult(await sender.Send(new GetAllRolesQuery()));
	}
	[HttpGet("user-roles/{id}")]
	public async Task<IActionResult> GetUserRoles(int id)
	{
		return NewResult(await sender.Send(new GetUserRolesQuery(id)));
	}
	[HttpPost("roles/{name}")]
	public async Task<IActionResult> AddRole(string name)
	{
		var command = new AddRoleCommand { Name = name };
		return NewResult(await sender.Send(command));
	}
	[HttpPut("roles")]
	public async Task<IActionResult> UpdateRole([FromBody] UpdateRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpDelete("roles/{id}")]
	public async Task<IActionResult> DeleteRole(int id)
	{
		var command = new DeleteRoleCommand { RoleId = id };
		return NewResult(await sender.Send(command));
	}
	[HttpPost("user-roles/remove")]
	public async Task<IActionResult> AddUserToRole([FromBody] RemoveUserFromRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPost("user-roles")]
	public async Task<IActionResult> AddUserToRole([FromBody] AddUserToRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPut("user-roles")]
	public async Task<IActionResult> UpdateUserToRole([FromBody] UpdateUserToRoleCommand command)
	{
		return NewResult(await sender.Send(command));
	}
}
