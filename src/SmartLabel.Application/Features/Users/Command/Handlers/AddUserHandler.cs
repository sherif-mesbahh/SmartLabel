using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities.Identity;
using System.Net;

namespace SmartLabel.Application.Features.Users.Command.Handlers;

public class AddUserHandler(IMapper mapper, UserManager<ApplicationUser> userManager, IEmailService emailService, IHttpContextAccessor httpContextAccessor) : ResponseHandler, IRequestHandler<AddUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddUserCommand request, CancellationToken cancellationToken)
	{
		var existingUser = await userManager.FindByEmailAsync(request.Email);
		if (existingUser != null)
		{
			return BadRequest<string>(
				message: "Registration failed",
				errors: [$"Email '{request.Email}' is already registered"]);

		}
		var user = mapper.Map<ApplicationUser>(request);
		var result = await userManager.CreateAsync(user, request.Password);
		if (!result.Succeeded)
		{
			var errors = result.Errors
				.Select(e => e.Description)
				.ToList();

			return BadRequest<string>(
				message: "User creation failed",
				errors: errors);
		}

		await userManager.AddToRoleAsync(user, Roles.User.ToString());
		//To do "Send confirm Email"
		var scheme = httpContextAccessor.HttpContext.Request.Scheme;
		var host = httpContextAccessor.HttpContext.Request.Host;
		var code = await userManager.GenerateEmailConfirmationTokenAsync(user);
		var encodedCode = WebUtility.UrlEncode(code); // or Uri.EscapeDataString(code)
		var url = $"{scheme}://{host}/api/Authentication/confirm-email?UserId={user.Id}&Code={encodedCode}";
		await emailService.Send(user.Email, "Verify your email", url);
		return Created<string>("User registered successfully");
	}
}