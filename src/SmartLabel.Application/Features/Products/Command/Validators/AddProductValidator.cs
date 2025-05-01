using FluentValidation;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Products.Command.Validators;
public class AddProductValidator : AbstractValidator<AddProductCommand>
{
	private readonly IProductRepository _productRepository;
	private readonly ICategoryRepository _categoryRepository;
	public AddProductValidator(IProductRepository repository, ICategoryRepository repo)
	{
		_productRepository = repository;
		_categoryRepository = repo;
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
			.MustAsync(async (name, cancellationToken) => !await _productRepository.IsProductNameExistAsync(name, cancellationToken))
			.WithMessage("Product name already exists.");
		RuleFor(x => x.CatId)
			.MustAsync(async (id, cancellationToken) => await _categoryRepository.IsCategoryExistAsync(id, cancellationToken))
			.WithMessage($"Category with this id is not found");
	}
}