using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[ApiController]
[Route("api/[controller]")]
public class ProductController(IMediator mediator) : AppControllerBase
{
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet]
	public async Task<IActionResult> GetAllProducts()
	{
		return NewResult(await mediator.Send(new GetAllProductsQuery()));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetProductById(int id)
	{
		return NewResult(await mediator.Send(new GetProductByIdQuery(id)));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpPost]
	public async Task<IActionResult> AddProduct([FromForm] AddProductCommand product)
	{
		return NewResult(await mediator.Send(product));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpPut]
	public async Task<IActionResult> UpdateProduct([FromForm] UpdateProductCommand product)
	{
		return NewResult(await mediator.Send(product));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteProduct(int id)
	{
		return NewResult(await mediator.Send(new DeleteProductCommand(id)));
	}
}
