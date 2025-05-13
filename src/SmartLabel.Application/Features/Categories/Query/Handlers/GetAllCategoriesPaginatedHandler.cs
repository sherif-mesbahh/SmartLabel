using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;

internal sealed class GetAllCategoriesPaginatedHandler(ICategoryProcRepository categoryProcRepository, IMemoryCache memoryCache)
	: ResponseHandler, IRequestHandler<GetAllCategoriesPaginatedQuery, PagedList<GetAllCategoriesDto>>
{
	public async Task<PagedList<GetAllCategoriesDto>> Handle(GetAllCategoriesPaginatedQuery request,
		CancellationToken cancellationToken)
	{
		(int totalCount, var cat) = await categoryProcRepository.GetAllCategoriesPaged(request);
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var categories = await PagedList<GetAllCategoriesDto>.CreateAsync(cat, totalCount, page, pageSize);
		return categories;
	}
}