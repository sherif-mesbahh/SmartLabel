using FluentValidation;
using SmartLabel.Application.Features.Users.Command.Models;

namespace SmartLabel.Application.Features.Users.Command.Validators;
public class UpdateUserValidator : AbstractValidator<UpdateUserCommand>
{
	public UpdateUserValidator()
	{
		ApplyValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.FirstName)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");

		RuleFor(x => x.LastName)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");

		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} is required");
	}

}