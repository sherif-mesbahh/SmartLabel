using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Products.Command.Handlers;
public class DeleteProductHandler(IProductRepository repository, IFileService fileService, IMemoryCache memoryCache
	, IHttpContextAccessor httpContextAccessor)
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
			var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
			InvalidCache(userId, product.Id);
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Deleting product temporarily unavailable");

		}
	}
	private void InvalidCache(string userId, int productId)
	{
		memoryCache.Remove($"ProductsUserId-");
		memoryCache.Remove($"ProductsUserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-");
	}
}
