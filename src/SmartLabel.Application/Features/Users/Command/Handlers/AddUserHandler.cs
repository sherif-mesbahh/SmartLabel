using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Command.Handlers;

public class AddUserHandler(IMapper mapper, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<AddUserCommand, Response<string>>
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
		return Created<string>("User registered successfully");
	}
}