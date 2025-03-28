using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Handlers;
public class AddUserFavProductHandler(IUserFavProductRepository userFavProductRepository, IProductRepository productRepository, IHttpContextAccessor httpContextAccessor) :
	ResponseHandler, IRequestHandler<AddUserFavProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddUserFavProductCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null) throw new SecurityTokenException("Please login first!");
		if (!await productRepository.IsProductExistAsync(request.ProductId))
			return NotFound<string>("This productId or userId is not found");
		var userFavProduct = new UserFavProduct()
		{
			Id = 0,
			UserId = int.Parse(userId),
			ProductId = request.ProductId
		};
		await userFavProductRepository.AddFavProductAsync(userFavProduct);
		return Created<string>("added to your favorites");
	}
}
