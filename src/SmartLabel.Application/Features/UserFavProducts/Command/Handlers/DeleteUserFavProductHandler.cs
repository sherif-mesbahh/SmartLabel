using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Handlers;
public class DeleteUserFavProductHandler(IUserFavProductRepository userFavProductRepository, IProductRepository productRepository,
	IMemoryCache memoryCache, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<DeleteUserFavProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteUserFavProductCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null)
			return Unauthorized<string>("Please login first");
		if (!await productRepository.IsProductExistAsync(request.ProductId))
			return NotFound<string>([$"Product ID: {request.ProductId} not found"], "Product discontinued");
		var userFavProduct = await userFavProductRepository.GetUserFavProductsAsync(int.Parse(userId), request.ProductId);
		if (userFavProduct is null)
			return NotFound<string>([$"Product {request.ProductId} not found for user {userId}"], "Product not found in favorites");
		try
		{
			await userFavProductRepository.DeleteFavProductAsync(userFavProduct.Id);
			InvalidCached(userId, request.ProductId);
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Failed to remove favorite");
		}
	}
	private void InvalidCached(string userId, int productId)
	{
		memoryCache.Remove($"ProductsUserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-{userId}");
	}
}