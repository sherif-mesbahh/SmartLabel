using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Products.Query.Handlers;
public class GetAllProductsHandler(IProductRepository repository, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetAllProductsQuery, Response<IEnumerable<GetAllProductsDto?>>>
{
	public async Task<Response<IEnumerable<GetAllProductsDto?>>> Handle(GetAllProductsQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var products = await repository.GetAllProductsAsync(userId);
		return Success(products, "All Products are retrieved successfully");
	}
}
