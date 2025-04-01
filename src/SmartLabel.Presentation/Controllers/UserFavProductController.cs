using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Authorize(Policy = nameof(Roles.UserOrAdmin))]
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
	public async Task<IActionResult> DeleteFavForProducts(int productId)
	{
		return NewResult(await mediator.Send(new DeleteUserFavProductCommand(productId)));
	}
	[HttpGet]
	public async Task<IActionResult> GetFavProductsForUser()
	{
		return NewResult(await mediator.Send(new GetFavProductsByUserQuery()));
	}

}
