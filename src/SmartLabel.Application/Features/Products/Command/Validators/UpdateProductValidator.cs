using FluentValidation;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Products.Command.Validators;
public class UpdateProductValidator : AbstractValidator<UpdateProductCommand>
{
	private readonly IProductRepository _repository;

	public UpdateProductValidator(IProductRepository repository)
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
		RuleFor(x => x.OldPrice)
			.GreaterThan(0).WithMessage("{PropertyName} must be greater than 0");

		RuleFor(x => x.CatId)
			.GreaterThan(0).WithMessage("{PropertyName} must be greater than 0");
	}

	private void AddCustomValidationRules()
	{
		RuleFor(x => x.Name)
			.MustAsync(async (productRequest, name, cancellationToken)
				=> !await _repository.IsProductNameAndIdExistAsync(productRequest.Id, name, cancellationToken))
			.WithMessage("{PropertyName} name already exists.");
	}
}