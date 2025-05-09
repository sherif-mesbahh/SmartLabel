using FluentValidation;
using SmartLabel.Application.Features.Users.Command.Models;

namespace SmartLabel.Application.Features.Users.Command.Validators;
public class AddUserValidator : AbstractValidator<AddUserCommand>
{
	public AddUserValidator()
	{
		ApplyValidationRules();

	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.FirstName)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.NotNull().WithMessage("{PropertyName} is required")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");

		RuleFor(x => x.LastName)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.NotNull().WithMessage("{PropertyName} is required")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");

		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} is required");

		RuleFor(x => x.Password)
			.NotEmpty().WithMessage("Passwrod must be required")
			.MinimumLength(8).WithMessage("Password must be at least 8 characters")
			.Matches("[A-Z]").WithMessage("Password must contain at least one uppercase letter (A-Z)")
			.Matches("[a-z]").WithMessage("Password must contain at least one lowercase letter (a-z)")
			.Matches("[0-9]").WithMessage("Password must contain at least one number (0-9)");

		RuleFor(x => x.ConfirmPassword)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.Equal(x => x.Password).WithMessage("Password and ConfirmPassword is not similar");
	}

}
