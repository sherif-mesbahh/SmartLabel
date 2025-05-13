using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Interfaces;

namespace SmartLabel.Application.Features.Users.Command.Handlers;

public class AddUserHandler(IMapper mapper, UserManager<ApplicationUser> userManager, IEmailService emailService, IUnitOfWork unitOfWork,
	IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<AddUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddUserCommand request, CancellationToken cancellationToken)
	{
		using var transaction = await unitOfWork.BeginTransaction();
		try
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
			await userManager.AddToRoleAsync(user, RolesEnum.User.ToString());
			var code = await userManager.GenerateEmailConfirmationTokenAsync(user);
			var url = emailService.PrepareUrl(user.Id, code);
			await emailService.Send(user.Email, "Confirm your email",
				$"Please confirm your account by <a href='{url}'>clicking here</a>");
			transaction.Commit();
			return Created<string>("User registered successfully");
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>([ex.Message], "Please register again!");
		}
	}
}