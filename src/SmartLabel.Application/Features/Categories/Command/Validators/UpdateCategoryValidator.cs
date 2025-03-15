using FluentValidation;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Categories.Command.Validators;
public class UpdateCategoryValidator : AbstractValidator<UpdateCategoryCommand>
{
	private readonly ICategoryRepository _repository;

	public UpdateCategoryValidator(ICategoryRepository repository)
	{
		_repository = repository;
		ApplyValidationRules();
		AddCustomValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.Name)
			.NotEmpty().WithMessage("{PropertyName} must be not empty")
			.NotNull().WithMessage("{PropertyName} must be not null")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");

		RuleFor(x => x.Id)
			.GreaterThan(0).WithMessage("{PropertyName} must be greater than 0");
	}

	private void AddCustomValidationRules()
	{
		RuleFor(x => x.Name)
			.MustAsync(async (categoryRequest, name, cancellationToken)
				=> !await _repository.IsCategoryNameAndIdExist(categoryRequest.Id, name, cancellationToken))
			.WithMessage("{PropertyName} name already exists.");
	}
}