using FluentValidation;
using SmartLabel.Application.Features.Users.Command.Models;

namespace SmartLabel.Application.Features.Users.Command.Validators;
public class AddUserValidator : AbstractValidator<AddUserCommand>
{
	public AddUserValidator()
	{
		ApplyValidationRules();
		AddCustomValidator();

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

		RuleFor(x => x.Password)
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.ConfirmPassword)
			.NotEmpty().WithMessage("{PropertyName} is required")
			.Equal(x => x.Password).WithMessage("Password and ConfirmPassword is not similar");
	}

	private void AddCustomValidator()
	{
		RuleFor(x => x.Password)
			.Must((x) => x?.Length >= 8)
			.WithMessage("Password length must be at least 8 characters");
		RuleFor(x => x.ConfirmPassword)
			.Must((x) => x?.Length >= 8)
			.WithMessage("ConfirmPassword length must be at least 8 characters");
	}
}
