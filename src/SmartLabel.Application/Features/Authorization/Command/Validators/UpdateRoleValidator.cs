using FluentValidation;
using SmartLabel.Application.Features.Authorization.Command.Models;

namespace SmartLabel.Application.Features.Authorization.Command.Validators;
public class UpdateRoleValidator : AbstractValidator<UpdateRoleCommand>
{
	public UpdateRoleValidator()
	{
		RuleFor(x => x.OldName)
			.NotEmpty().WithMessage("{PropertyName} is required");
		RuleFor(x => x.NewName)
			.NotEmpty().WithMessage("{PropertyName} is required");
	}
}
