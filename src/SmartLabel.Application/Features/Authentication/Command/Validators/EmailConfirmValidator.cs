using FluentValidation;
using SmartLabel.Application.Features.Authentication.Command.Models;

namespace SmartLabel.Application.Features.Authentication.Command.Validators;
public class EmailConfirmValidator : AbstractValidator<EmailConfirmCommand>
{
	public EmailConfirmValidator()
	{
		ApplyValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.UserId)
			.NotEmpty().WithMessage("{PropertyName} must be required");
		RuleFor(x => x.Code)
			.NotEmpty().WithMessage("{PropertyName} must be required");
	}
}