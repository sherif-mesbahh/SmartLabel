using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.Categories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;
public class GetCategoryByIdHandler(ICategoryRepository categoryRepository) : ResponseHandler,
	IRequestHandler<GetCategoryByIdQuery, Response<GetCategoryByIdDto>>
{
	public async Task<Response<GetCategoryByIdDto>> Handle(GetCategoryByIdQuery request, CancellationToken cancellationToken)
	{
		var category = await categoryRepository.GetCategoryByIdAsync(request.Id);
		if (category is null) return NotFound<GetCategoryByIdDto>("Category with ID " + request.Id + " not found");
		return Success(category, "Category is getting successfully");
	}
}