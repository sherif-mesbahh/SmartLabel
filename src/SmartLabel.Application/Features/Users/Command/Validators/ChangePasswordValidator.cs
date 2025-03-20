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
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.ConfirmPassword)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.Equal(x => x.NewPassword).WithMessage("Password and ConfirmPassword is not similar");
	}
}
