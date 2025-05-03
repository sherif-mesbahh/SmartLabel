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
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.Password)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.Equal(x => x.ConfirmPassword).WithMessage("Password and ConfirmPassword is not similar");
	}
}