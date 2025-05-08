using FluentValidation;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Banners.Command.Validators;
public class UpdateBannerValidator : AbstractValidator<UpdateBannerCommand>
{
	private IBannerRepository BannerRepository { get; }

	public UpdateBannerValidator(IBannerRepository bannerRepository)
	{
		BannerRepository = bannerRepository;
		ApplyValidationRules();
		AddCustomValidationRules();
	}
	private void ApplyValidationRules()
	{
		RuleFor(x => x.Title)
			.NotEmpty().WithMessage("{PropertyName} must be not empty")
			.NotNull().WithMessage("{PropertyName} must be not null")
			.MaximumLength(1000).WithMessage("{PropertyName} cannot exceed 1000 characters.");
		RuleFor(x => x.Description)
			.MaximumLength(2000).WithMessage("{PropertyName} cannot exceed 2000 characters.");
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