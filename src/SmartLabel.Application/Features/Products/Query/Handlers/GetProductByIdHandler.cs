using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.Products;

namespace SmartLabel.Application.Features.Products.Query.Handlers;

public class GetProductByIdHandler(IProductRepository repository) : ResponseHandler, IRequestHandler<GetProductByIdQuery, Response<GetProductByIdDto>>
{
	public async Task<Response<GetProductByIdDto>> Handle(GetProductByIdQuery request, CancellationToken cancellationToken)
	{
		var product = await repository.GetProductByIdAsync(request.Id);
		if (product is null) throw new KeyNotFoundException("Product with ID " + request.Id + " not found");
		return Success(product, "product is getting successfully");
	}
}