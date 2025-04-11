using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Products.Query.Handlers;
public class GetAllProductsHandler(IProductRepository repository) : ResponseHandler, IRequestHandler<GetAllProductsQuery, Response<IEnumerable<GetAllProductsDto?>>>
{
	public async Task<Response<IEnumerable<GetAllProductsDto?>>> Handle(GetAllProductsQuery request, CancellationToken cancellationToken)
	{
		var products = await repository.GetAllProductsAsync();
		return Success(products, "All Products are retrieved successfully");
	}
}
