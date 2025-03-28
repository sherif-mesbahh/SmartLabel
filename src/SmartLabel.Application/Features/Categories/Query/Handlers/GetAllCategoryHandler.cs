using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.Categories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;
public class GetAllCategoryHandler(ICategoryRepository categoryRepository) : ResponseHandler
	, IRequestHandler<GetAllCategoryQuery, Response<IEnumerable<GetAllCategoriesDto?>>>
{
	public async Task<Response<IEnumerable<GetAllCategoriesDto?>>> Handle(GetAllCategoryQuery request, CancellationToken cancellationToken)
	{
		var categories = await categoryRepository.GetAllCategoriesAsync();
		return Success(categories, "All Categories are getting successfully");
	}
}

