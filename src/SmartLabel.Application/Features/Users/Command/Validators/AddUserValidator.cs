using FluentValidation;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Command.Validators;
public class AddUserValidator : AbstractValidator<AddUserCommand>
{
	private readonly UserManager<ApplicationUser> _userManager;

	public AddUserValidator(UserManager<ApplicationUser> userManager)
	{
		_userManager = userManager;
		ApplyValidationRules();
		AddCustomValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.FirstName)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");

		RuleFor(x => x.LastName)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");

		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} is required");

		RuleFor(x => x.ConfirmPassword)
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.Password)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.Equal(x => x.ConfirmPassword).WithMessage("Password and ConfirmPassword is not similar");
	}

	private void AddCustomValidationRules()
	{
		RuleFor(x => x.Email)
			.MustAsync(async (email, cancellationToken) => await _userManager.FindByEmailAsync(email) is null)
			.WithMessage("Email is already exist.");
	}
}
