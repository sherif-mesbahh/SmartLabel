using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;
public class GetAllCategoryHandler(ICategoryRepository categoryRepository) : ResponseHandler
	, IRequestHandler<GetAllCategoryQuery, Response<IEnumerable<GetAllCategoriesDto?>>>
{
	public async Task<Response<IEnumerable<GetAllCategoriesDto?>>> Handle(GetAllCategoryQuery request, CancellationToken cancellationToken)
	{
		var categories = await categoryRepository.GetAllCategoriesAsync();
		return Success(categories, "All categories retrieved successfully");
	}
}

