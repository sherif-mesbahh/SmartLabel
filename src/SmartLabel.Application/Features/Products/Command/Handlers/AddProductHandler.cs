using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Products.Command.Handlers;

public class AddProductHandler(IMapper mapper, IProductRepository repository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<AddProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddProductCommand request, CancellationToken cancellationToken)
	{
		using var transaction = await unitOfWork.BeginTransaction();
		try
		{
			var product = mapper.Map<Product>(request);
			await repository.AddProductAsync(product);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			if (request.ImagesFiles is not null)
			{
				var productImages = new List<ProductImage>();
				foreach (var image in request.ImagesFiles)
				{
					var productImage = new ProductImage()
					{
						Id = 0,
						ImageUrl = await fileService.BuildImageAsync(image),
						ProductId = product.Id
					};
					productImages.Add(productImage);
				}
				await repository.AddProductImagesAsync(productImages);
			}
			await unitOfWork.SaveChangesAsync(cancellationToken);
			transaction.Commit();
			return Created<string>($"Product with {product.Id} is added successfully");
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>($"{ex.Message}");
		}
	}
}
