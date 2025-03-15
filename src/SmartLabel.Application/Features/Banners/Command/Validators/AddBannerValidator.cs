using FluentValidation;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Banners.Command.Validators;
public class AddBannerValidator : AbstractValidator<AddBannerCommand>
{
	private readonly IBannerRepository _repository;

	public AddBannerValidator(IBannerRepository repository)
	{
		_repository = repository;
		ApplyValidationRules();
		AddCustomValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.Title)
			.NotEmpty().WithMessage("{PropertyName} must be not empty")
			.NotNull().WithMessage("{PropertyName} must be not null")
			.MaximumLength(200).WithMessage("{PropertyName} cannot exceed 200 characters.");
		RuleFor(x => x.ImagesFiles)
			.NotNull().WithMessage("You must put at least a image");
	}
	private void AddCustomValidationRules()
	{
		RuleFor(x => x.StartDate)
			.Must(startDate => startDate != default)
			.WithMessage("{PropertyName} is not valid date time");
		RuleFor(x => x.EndDate)
			.Must(endDate => endDate != default)
			.WithMessage("{PropertyName} is not valid date time");
		RuleFor(x => x.StartDate)
			.Must((bannerRequest, startDate) => bannerRequest.EndDate > startDate)
			.WithMessage("EndDate should be greater than startDate");
	}
}