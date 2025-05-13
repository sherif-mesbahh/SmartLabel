using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Authentication.Command.Models;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AuthenticationController(ISender sender) : AppControllerBase
{
	[HttpPost("register")]
	public async Task<IActionResult> Register(AddUserCommand user)
	{
		return NewResult(await sender.Send(user));
	}
	[HttpPost("login")]
	public async Task<IActionResult> SignIn([FromBody] SignInCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPost("refresh-token")]
	public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[Authorize(Policy = nameof(RolesEnum.UserOrAdmin))]
	[HttpPost("logout")]
	public async Task<IActionResult> RefreshToken()
	{
		return NewResult(await sender.Send(new LogoutCommand()));
	}

	[HttpGet("confirm-email")]
	public async Task<IActionResult> ConfirmEmail([FromQuery] EmailConfirmCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPost("forget-password")]
	public async Task<IActionResult> ForgetPassword(ForgetPasswordCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPost("reset-code")]
	public async Task<IActionResult> ResetCode(EnterCodeToResetCommand command)
	{
		return NewResult(await sender.Send(command));
	}
	[HttpPost("reset-password")]
	public async Task<IActionResult> ForgetPassword([FromBody] ResetPasswordCommand command)
	{
		return NewResult(await sender.Send(command));
	}
}