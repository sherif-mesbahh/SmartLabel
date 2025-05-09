using FluentValidation;
using SmartLabel.Application.Features.Authentication.Command.Models;

namespace SmartLabel.Application.Features.Authentication.Command.Validators;
public class ResetPasswordValidator : AbstractValidator<ResetPasswordCommand>
{
	public ResetPasswordValidator()
	{
		ApplyValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} must be required");

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