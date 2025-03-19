using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Route("api/[controller]")]
[ApiController]
public class UserController(IMediator mediator) : AppControllerBase
{
	[HttpPost]
	public async Task<IActionResult> AddUser(AddUserCommand user)
	{
		return NewResult(await mediator.Send(user));
	}
}