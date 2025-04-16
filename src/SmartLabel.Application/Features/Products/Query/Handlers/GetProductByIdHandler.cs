using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Products.Query.Handlers;

public class GetProductByIdHandler(IProductRepository repository, IHttpContextAccessor httpContextAccessor) : ResponseHandler, IRequestHandler<GetProductByIdQuery, Response<GetProductByIdDto>>
{
	public async Task<Response<GetProductByIdDto>> Handle(GetProductByIdQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));

		var product = await repository.GetProductByIdUserAsync(request.Id, userId);
		if (product is null)
			throw new KeyNotFoundException("Product with ID " + request.Id + " not found");
		return Success(product, "product retrieved successfully");
	}
}