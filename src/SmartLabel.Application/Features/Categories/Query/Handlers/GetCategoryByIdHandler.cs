using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers
{
	public class GetCategoryByIdHandler(ICategoryRepository repository, IMapper mapper) : ResponseHandler,
		IRequestHandler<GetCategoryByIdQuery, Response<GetCategoryResultById>>
	{
		public async Task<Response<GetCategoryResultById>> Handle(GetCategoryByIdQuery request, CancellationToken cancellationToken)
		{
			var cat = await repository.GetCategoryById(request.Id);
			if (cat is null) throw new KeyNotFoundException("Category with ID " + request.Id + " not found");
			var category = mapper.Map<GetCategoryResultById>(cat);
			return Success(category, "Category is getting successfully");
		}
	}
}
