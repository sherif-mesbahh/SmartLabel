using FluentValidation;
using SmartLabel.Application.Features.Users.Command.Models;

namespace SmartLabel.Application.Features.Users.Command.Validators;
public class ChangePasswordValidator : AbstractValidator<ChangePasswordCommand>
{

	public ChangePasswordValidator()
	{
		ApplyValidationRules();
	}
	private void ApplyValidationRules()
	{

		RuleFor(x => x.NewPassword)
			.NotEmpty().WithMessage("New Passwrod must be required")
			.MinimumLength(8).WithMessage("New Password must be at least 8 characters")
			.Matches("[A-Z]").WithMessage("New Password must contain at least one uppercase letter (A-Z)")
			.Matches("[a-z]").WithMessage("New Password must contain at least one lowercase letter (a-z)")
			.Matches("[0-9]").WithMessage("New Password must contain at least one number (0-9)");
		RuleFor(x => x.ConfirmPassword)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.Equal(x => x.NewPassword).WithMessage("Password and ConfirmPassword is not similar");
	}
}
