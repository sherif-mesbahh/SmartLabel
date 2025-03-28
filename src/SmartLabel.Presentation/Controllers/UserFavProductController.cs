using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Domain.Shared.Helpers;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class UserFavProductController(IMediator mediator) : AppControllerBase
{
	[HttpPost("{productId:int}")]
	public async Task<IActionResult> AddFavForProduct(int productId)
	{
		return NewResult(await mediator.Send(new AddUserFavProductCommand(productId)));
	}
	[HttpDelete("{productId:int}")]
	public async Task<IActionResult> DeleteFavForProduct(int productId)
	{
		return NewResult(await mediator.Send(new DeleteUserFavProductCommand(productId)));
	}
	[HttpGet]
	public async Task<IActionResult> GetFavProductsByUserId()
	{
		var userId = User.FindFirst(nameof(UserClaimModel.UserId))?.Value;
		if (userId is null) throw new SecurityTokenException("You are not authenticated! please login first");
		return NewResult(await mediator.Send(new GetFavProductsByUserQuery(int.Parse(userId))));
	}

}
