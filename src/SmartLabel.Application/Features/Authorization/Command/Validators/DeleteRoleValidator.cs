using FluentValidation;
using SmartLabel.Application.Features.Authorization.Command.Models;

namespace SmartLabel.Application.Features.Authorization.Command.Validators;
public class DeleteRoleValidator : AbstractValidator<DeleteRoleCommand>
{
	public DeleteRoleValidator()
	{
		RuleFor(x => x.Name)
			.NotEmpty().WithMessage("{PropertyName} is required");
	}
}
