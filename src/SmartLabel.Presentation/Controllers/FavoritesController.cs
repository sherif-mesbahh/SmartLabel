using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Authorize(Policy = nameof(Roles.UserOrAdmin))]
[Route("api")]
[ApiController]
public class FavoritesController(ISender sender) : AppControllerBase
{
	[HttpGet("me/favorites")]
	public async Task<IActionResult> GetFavProductsForUser()
	{
		return NewResult(await sender.Send(new GetFavProductsByUserQuery()));
	}
	[HttpGet("me/favorites/paginated")]
	public async Task<PagedList<GetAllProductsDto>> GetFavProductsPaginatedForUser([FromQuery] GetFavProductsPaginatedByUserQuery query)
	{
		return await sender.Send(query);
	}

	[HttpPost("me/favorites/{productId:int}")]
	public async Task<IActionResult> AddFavForProduct(int productId)
	{
		return NewResult(await sender.Send(new AddUserFavProductCommand(productId)));
	}
	[HttpDelete("me/favorites/{productId:int}")]
	public async Task<IActionResult> DeleteFavForProducts(int productId)
	{
		return NewResult(await sender.Send(new DeleteUserFavProductCommand(productId)));
	}

}
