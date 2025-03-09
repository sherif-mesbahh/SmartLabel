using FluentValidation;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Categories.Command.Validators;
public class AddCategoryValidator : AbstractValidator<AddCategoryCommand>
{
	private readonly ICategoryRepository _repository;

	public AddCategoryValidator(ICategoryRepository repository)
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
	}

	private void AddCustomValidationRules()
	{
		RuleFor(x => x.Name)
			.MustAsync(async (name, cancellationToken) => !await _repository.IsCategoryNameExist(name, cancellationToken))
			.WithMessage("Category name already exists.");

	}
}