using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Products.Command.Handlers;
public class DeleteProductHandler(IProductRepository repository, IFileService fileService)
	: ResponseHandler, IRequestHandler<DeleteProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteProductCommand request, CancellationToken cancellationToken)
	{
		var product = await repository.GetProductByIdAsync(request.Id);
		if (product is null) throw new KeyNotFoundException("Product with ID " + request.Id + " not found");
		try
		{
			if (product.Images is not null)
			{
				foreach (var image in product.Images)
					await fileService.DeleteImageAsync(image);
			}
			await repository.DeleteProductAsync(request.Id);
			return Deleted<string>($"Product with id {request.Id} is deleted Successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"{ex.Message}");
		}
	}
}
