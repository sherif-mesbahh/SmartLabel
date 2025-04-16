using FluentValidation;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Repositories;

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
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");
		RuleFor(x => x.Description)
			.MaximumLength(20000).WithMessage("{PropertyName} cannot exceed 20000 characters.");
		RuleFor(x => x.OldPrice)
			.GreaterThan(0).WithMessage("{PropertyName} must be greater than 0");

		RuleFor(x => x.CatId)
			.GreaterThan(0).WithMessage("{PropertyName} must be greater than 0");

		RuleFor(x => x.MainImage)
			.NotEmpty().WithMessage("You should upload at least one Image");
	}

	private void AddCustomValidationRules()
	{
		RuleFor(x => x.Name)
			.MustAsync(async (productRequest, name, cancellationToken)
				=> !await _repository.IsProductNameAndIdExistAsync(productRequest.Id, name, cancellationToken))
			.WithMessage("{PropertyName} name already exists.");
	}
}