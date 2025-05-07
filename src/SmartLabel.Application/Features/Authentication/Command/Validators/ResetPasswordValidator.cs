using FluentValidation;
using SmartLabel.Application.Features.Authentication.Command.Models;

namespace SmartLabel.Application.Features.Authentication.Command.Validators;
public class ResetPasswordValidator : AbstractValidator<ResetPasswordCommand>
{
	public ResetPasswordValidator()
	{
		ApplyValidationRules();
		AddCustomValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} must be required");

		RuleFor(x => x.Password)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.NotNull().WithMessage("{PropertyName} is required");
		RuleFor(x => x.ConfirmPassword)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.NotNull().WithMessage("{PropertyName} is required")
			.Equal(x => x.Password).WithMessage("Password and ConfirmPassword is not similar");
	}
	private void AddCustomValidationRules()
	{
		RuleFor(x => x.Password)
			.Must((x) => x?.Length >= 8)
			.WithMessage("Password length must be at least 8 characters");
		RuleFor(x => x.ConfirmPassword)
			.Must((x) => x?.Length >= 8)
			.WithMessage("ConfirmPassword length must be at least 8 characters");
	}
}