using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Products.Command.Handlers;
public class DeleteProductHandler(IProductRepository repository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<DeleteProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteProductCommand request, CancellationToken cancellationToken)
	{
		if (!await repository.IsProductExist(request.Id))
		{
			return NotFound<string>($"The product with id {request.Id} is not found");
		}

		try
		{
			var product = await repository.GetProductById(request.Id);
			if (product?.Images is not null)
			{
				foreach (var image in product.Images)
				{
					await fileService.DeleteImageAsync(image.ImageUrl);
				}
			}

			repository.DeleteProduct(product);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			return Deleted<string>("This product is deleted Successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}
