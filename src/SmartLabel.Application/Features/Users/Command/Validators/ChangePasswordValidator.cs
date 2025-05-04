using FluentValidation;
using SmartLabel.Application.Features.Users.Command.Models;

namespace SmartLabel.Application.Features.Users.Command.Validators;
public class ChangePasswordValidator : AbstractValidator<ChangePasswordCommand>
{

	public ChangePasswordValidator()
	{
		ApplyValidationRules();
		AddCustomValidators();
	}
	private void ApplyValidationRules()
	{

		RuleFor(x => x.NewPassword)
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.ConfirmPassword)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.Equal(x => x.NewPassword).WithMessage("Password and ConfirmPassword is not similar");
	}

	private void AddCustomValidators()
	{
		RuleFor(x => x.NewPassword)
			.Must((x) => x?.Length >= 8)
			.WithMessage("NewPassword length must be at least 8 characters");
		RuleFor(x => x.ConfirmPassword)
			.Must((x) => x?.Length >= 8)
			.WithMessage("ConfirmPassword length must be at least 8 characters");
	}
}
