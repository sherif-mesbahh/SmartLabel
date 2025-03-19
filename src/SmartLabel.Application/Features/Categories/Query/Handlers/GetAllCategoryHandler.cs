using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;
public class GetAllCategoryHandler(IMapper mapper, ICategoryRepository repository) : ResponseHandler
	,IRequestHandler<GetAllCategoryQuery, Response<IEnumerable<GetAllCategoryResult>>>
{
	public async Task<Response<IEnumerable<GetAllCategoryResult>>> Handle(GetAllCategoryQuery request, CancellationToken cancellationToken)
	{
		var categories = mapper.Map<IEnumerable<GetAllCategoryResult>>(await repository.GetAllCategory());
		return Success(categories, "All Categories getting successfully");
	}
}

