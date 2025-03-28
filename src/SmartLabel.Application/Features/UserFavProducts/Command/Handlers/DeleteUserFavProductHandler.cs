using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Handlers;
public class DeleteUserFavProductHandler(IUserFavProductRepository userFavProductRepository, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<DeleteUserFavProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteUserFavProductCommand request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		if (userId is null) throw new SecurityTokenException("You are not authenticated");
		var userFavProduct = await userFavProductRepository.GetUserFavProductAsync(int.Parse(userId), request.ProductId);
		if (userFavProduct is null)
			return NotFound<string>("This productId or userId is not found");
		await userFavProductRepository.DeleteFavProductAsync(userFavProduct.Id);
		return Deleted<string>("Like is Deleted successfully");
	}
}