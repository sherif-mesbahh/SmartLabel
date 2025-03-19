using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Products.Query.Handlers;

public class GetProductByIdHandler(IMapper mapper, IProductRepository repository) : ResponseHandler, IRequestHandler<GetProductByIdQuery, Response<GetProductByIdResult>>
{
	public async Task<Response<GetProductByIdResult>> Handle(GetProductByIdQuery request, CancellationToken cancellationToken)
	{
		var pro = await repository.GetProductById(request.Id);
		if (pro is null) throw new KeyNotFoundException("Product with ID " + request.Id + " not found");
		var product = mapper.Map<GetProductByIdResult>(pro);
		return Success(product, "product is getting successfully");
	}
}