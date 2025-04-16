using FluentValidation;
using SmartLabel.Application.Features.Authorization.Command.Models;

namespace SmartLabel.Application.Features.Authorization.Command.Validators;
public class AddRoleValidator : AbstractValidator<AddRoleCommand>
{
	public AddRoleValidator()
	{
		RuleFor(x => x.Name)
			.NotEmpty().WithMessage("{PropertyName} is required");
	}
}
