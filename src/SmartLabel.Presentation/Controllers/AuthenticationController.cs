using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AuthenticationController(IMediator mediator) : AppControllerBase
{
	[HttpPost("Login")]
	public async Task<IActionResult> SignIn([FromForm] SignInCommand command)
	{
		return NewResult(await mediator.Send(command));
	}
	[HttpPost("Refresh Token")]
	public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenCommand command)
	{
		return NewResult(await mediator.Send(command));
	}
	[HttpPost("Logout")]
	public async Task<IActionResult> RefreshToken([FromBody] LogoutCommand command)
	{
		return NewResult(await mediator.Send(command));
	}
}