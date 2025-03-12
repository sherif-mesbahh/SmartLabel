using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Products.Command.Handlers
{
	public class UpdateProductHandler(IMapper mapper, IProductRepository repository) : ResponseHandler, IRequestHandler<UpdateProductCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(UpdateProductCommand request, CancellationToken cancellationToken)
		{
			var product = mapper.Map<Product>(request);
			await repository.UpdateProduct(product);
			return Updated<string>("Product is Updated successfully");
		}
	}
}
