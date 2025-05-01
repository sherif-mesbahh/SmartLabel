using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;

namespace SmartLabel.Application.Features.Products.Command.Handlers;
public class DeleteProductHandler(IProductRepository repository, IFileService fileService)
	: ResponseHandler, IRequestHandler<DeleteProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteProductCommand request, CancellationToken cancellationToken)
	{
		var product = await repository.GetProductByIdAsync(request.Id);
		if (product is null)
			return NotFound<string>([$"Product ID: {request.Id} not found"], "Product discontinued");

		try
		{
			if (product.MainImage is not null)
				await fileService.DeleteImageAsync(product.MainImage);
			if (product.Images is not null)
			{
				foreach (var image in product.Images)
					await fileService.DeleteImageAsync(image.ImageUrl);
			}
			await repository.DeleteProductAsync(request.Id);
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Deleting product temporarily unavailable");

		}
	}
}
