using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;

namespace SmartLabel.Application.Features.Products.Query.Handlers;
internal sealed class GetAllProductsPaginatedHandler(IProductProcRepository productProcRepository) : ResponseHandler, IRequestHandler<GetAllProductsPaginatedQuery, PagedList<GetAllProductsDto>>
{
	public async Task<PagedList<GetAllProductsDto>> Handle(GetAllProductsPaginatedQuery request, CancellationToken cancellationToken)
	{
		(int totalCount, var pro) = await productProcRepository.GetAllCategoriesPaged(request);
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var products = PagedList<GetAllProductsDto>.CreateAsync(pro, totalCount, page, pageSize);
		return await products;
	}
}