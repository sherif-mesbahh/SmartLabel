using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Products.Command.Handlers;

public class AddProductHandler(IMapper mapper, IProductRepository repository) : ResponseHandler, IRequestHandler<AddProductCommand, Response<AddProductCommand>>
{
	public async Task<Response<AddProductCommand>> Handle(AddProductCommand request, CancellationToken cancellationToken)
	{
		var product = mapper.Map<Product>(request);
		await repository.AddProduct(product);
		request.Id = product.Id;
		return Created(request, "Product is added successfully");
	}
}
