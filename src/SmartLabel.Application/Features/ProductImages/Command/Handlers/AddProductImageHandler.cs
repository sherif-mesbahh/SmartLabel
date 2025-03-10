using AutoMapper;
using MediatR;
using SmartLabel.Application.Features.ProductImages.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.ProductImages.Command.Handlers
{
	public class AddProductImageHandler(IMapper mapper, IProductImageRepository repository) : IRequestHandler<AddProductImageCommand>
	{
		public async Task Handle(AddProductImageCommand request, CancellationToken cancellationToken)
		{
			var productImage = mapper.Map<ProductImage>(request);
			await repository.AddProductImage(productImage);
		}
	}
}
