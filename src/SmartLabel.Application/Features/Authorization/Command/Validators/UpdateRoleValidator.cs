using FluentValidation;
using SmartLabel.Application.Features.Authorization.Command.Models;

namespace SmartLabel.Application.Features.Authorization.Command.Validators;
public class UpdateRoleValidator : AbstractValidator<UpdateRoleCommand>
{
	public UpdateRoleValidator()
	{
		RuleFor(x => x.RoleId)
			.GreaterThan(0).WithErrorCode("{PropertyName} must be greater than 0");
		RuleFor(x => x.NewName)
			.NotEmpty().WithMessage("{PropertyName} is required");
	}
}
