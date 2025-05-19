using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Handlers;
public class AddUserFavProductHandler(IUserFavProductRepository userFavProductRepository, IProductRepository productRepository,
	IMemoryCache memoryCache, IHttpContextAccessor httpContextAccessor) :
	ResponseHandler, IRequestHandler<AddUserFavProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddUserFavProductCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null)
			return Unauthorized<string>("Please login first");
		if (!await productRepository.IsProductExistAsync(request.ProductId))
			return NotFound<string>([$"Product ID: {request.ProductId} not found"], "Product discontinued");

		if (await userFavProductRepository.IsFavoriteExistAsync(int.Parse(userId), request.ProductId))
			return Success($"Product {request.ProductId} was already in your favorites");

		var userFavProduct = new UserFavProduct()
		{
			Id = 0,
			UserId = int.Parse(userId),
			ProductId = request.ProductId
		};
		await userFavProductRepository.AddFavProductAsync(userFavProduct);
		InvalidCached(userId, request.ProductId, await productRepository.GetCatIdByProductId(request.ProductId));
		return Created<string>($"Product {request.ProductId} added to favorites");
	}
	private void InvalidCached(string userId, int productId, int catId)
	{
		memoryCache.Remove($"ProductsUserId-{userId}");
		memoryCache.Remove($"ProductId-{productId}UserId-{userId}");
		memoryCache.Remove($"ProductsFav-{userId}");
		memoryCache.Remove($"CategoryId-{catId}UserId-{userId}");
	}
}
