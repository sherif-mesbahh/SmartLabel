using FluentValidation;
using SmartLabel.Application.Features.Categories.Query.Models;

namespace SmartLabel.Application.Features.Categories.Query.Validators
{
	public class GetCategoryByIdValidator : AbstractValidator<GetCategoryByIdQuery>
	{
		public GetCategoryByIdValidator()
		{
			RuleFor(x => x.Id)
				.GreaterThan(0).WithMessage("Id must be greater than 0");
		}
	}
}
