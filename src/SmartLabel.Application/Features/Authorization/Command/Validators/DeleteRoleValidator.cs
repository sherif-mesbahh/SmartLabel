using FluentValidation;
using SmartLabel.Application.Features.Authorization.Command.Models;

namespace SmartLabel.Application.Features.Authorization.Command.Validators;
public class DeleteRoleValidator : AbstractValidator<DeleteRoleCommand>
{
	public DeleteRoleValidator()
	{
		RuleFor(x => x.RoleId)
			.GreaterThan(0).WithErrorCode("{PropertyName} must be greater than 0");
	}
}
