using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;
public class GetCategoryByIdHandler(ICategoryRepository categoryRepository) : ResponseHandler,
	IRequestHandler<GetCategoryByIdQuery, Response<GetCategoryByIdDto>>
{
	public async Task<Response<GetCategoryByIdDto>> Handle(GetCategoryByIdQuery request, CancellationToken cancellationToken)
	{
		var category = await categoryRepository.GetCategoryByIdAsync(request.Id);
		if (category is null)
			return NotFound<GetCategoryByIdDto>([$"Category ID: {request.Id} not found"], "Category discontinued");
		return Success(category, $"Banner {request.Id} retrieved successfully");
	}
}