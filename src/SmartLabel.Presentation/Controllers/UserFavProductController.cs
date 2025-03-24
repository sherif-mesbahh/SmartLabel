using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Infrastructure.Helpers;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Authorize]
[Route("api/[controller]")]
[ApiController]
public class UserFavProductController(IMediator mediator) : AppControllerBase
{
	[HttpPost("{productId:int}")]
	public async Task<IActionResult> AddFavoriteForProduct(int productId)
	{
		var userId = User.FindFirst(nameof(UserClaimModel.UserId))?.Value;
		if (userId is null) throw new SecurityTokenException("You are not authenticated! please login first");
		var command = new AddUserFavProductCommand() { UserId = int.Parse(userId), ProductId = productId };
		return NewResult(await mediator.Send(command));
	}
	[HttpDelete("{productId:int}")]
	public async Task<IActionResult> DeleteFavoriteForProduct(int productId)
	{
		var userId = User.FindFirst(nameof(UserClaimModel.UserId))?.Value;
		if (userId is null) throw new SecurityTokenException("You are not authenticated! please login first");
		var command = new DeleteUserFavProductCommand() { UserId = int.Parse(userId), ProductId = productId };
		return NewResult(await mediator.Send(command));
	}
	[HttpGet()]
	public async Task<IActionResult> GetFavProductsForUser()
	{
		var userId = User.FindFirst(nameof(UserClaimModel.UserId))?.Value;
		if (userId is null) throw new SecurityTokenException("You are not authenticated! please login first");
		return NewResult(await mediator.Send(new GetFavProductsByUserQuery(int.Parse(userId))));
	}

}
