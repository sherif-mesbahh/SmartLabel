using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class AuthenticationController(IMediator mediator) : AppControllerBase
{
	[AllowAnonymous]
	[HttpPost("login")]
	public async Task<IActionResult> SignIn([FromBody] SignInCommand command)
	{
		return NewResult(await mediator.Send(command));
	}
	[HttpPost("refresh-token")]
	public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenCommand command)
	{
		return NewResult(await mediator.Send(command));
	}
	[HttpPost("logout")]
	public async Task<IActionResult> RefreshToken()
	{
		return NewResult(await mediator.Send(new LogoutCommand()));
	}
}