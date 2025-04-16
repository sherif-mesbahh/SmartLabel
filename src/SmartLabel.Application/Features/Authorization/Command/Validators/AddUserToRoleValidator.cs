using FluentValidation;
using SmartLabel.Application.Features.Authorization.Command.Models;

namespace SmartLabel.Application.Features.Authorization.Command.Validators;
public class AddUserToRoleValidator : AbstractValidator<AddUserToRoleCommand>
{
	public AddUserToRoleValidator()
	{
		RuleFor(x => x.Email)
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.RoleName)
			.NotEmpty().WithMessage("{PropertyName} is required");
	}
}