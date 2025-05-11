using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Products.Query.Handlers;
internal sealed class GetAllProductsPaginatedHandler(IProductProcRepository productProcRepository, IMemoryCache memoryCache,
	IHttpContextAccessor httpContextAccessor) : ResponseHandler, IRequestHandler<GetAllProductsPaginatedQuery, PagedList<GetAllProductsDto>>
{
	public async Task<PagedList<GetAllProductsDto>> Handle(GetAllProductsPaginatedQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		(int totalCount, var pro) = await productProcRepository.GetAllProductsPaged(request, userId);
		var pageSize = (request.PageSize == 0 ? 10 : request.PageSize);
		var page = (request.PageNumber == 0 ? 1 : request.PageNumber);
		var products = await PagedList<GetAllProductsDto>.CreateAsync(pro, totalCount, page, pageSize);
		return products;
	}
}