using FluentValidation;
using SmartLabel.Application.Features.Authentication.Command.Models;

namespace SmartLabel.Application.Features.Authentication.Command.Validators;
public class SignInValidator : AbstractValidator<SignInCommand>
{
	public SignInValidator()
	{
		ApplyValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.Password)
			.NotEmpty().WithMessage("{PropertyName} is required");
	}
}
