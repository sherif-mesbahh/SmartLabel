using FluentValidation;
using SmartLabel.Application.Features.Authentication.Command.Models;

namespace SmartLabel.Application.Features.Authentication.Command.Validators;
public class EnterCodeToResetValidator : AbstractValidator<EnterCodeToResetCommand>
{
	public EnterCodeToResetValidator()
	{
		ApplyValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} must be required")
			.NotNull().WithMessage("{PropertyName} must be required");

		RuleFor(x => x.Code)
			.NotEmpty().WithMessage("{PropertyName} must be required")
			.NotNull().WithMessage("{PropertyName} must be required");
	}
}