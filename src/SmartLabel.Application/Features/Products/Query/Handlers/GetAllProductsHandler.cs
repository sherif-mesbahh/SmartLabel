using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Products.Query.Handlers;
public class GetAllProductsHandler(IMapper mapper, IProductRepository repository) : ResponseHandler, IRequestHandler<GetAllProductsQuery, Response<IEnumerable<GetAllProductsResult>>>
{
	public async Task<Response<IEnumerable<GetAllProductsResult>>> Handle(GetAllProductsQuery request, CancellationToken cancellationToken)
	{
		var products = mapper.Map<IEnumerable<GetAllProductsResult>>(await repository.GetAllProducts());
		return Success(products, "All Products getting successfully");
	}
}
