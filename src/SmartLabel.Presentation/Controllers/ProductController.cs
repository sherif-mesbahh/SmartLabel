using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Domain.Services;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ProductController(IMediator mediator, IFileService fileService) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllProducts()
	{
		return NewResult(await mediator.Send(new GetAllProductsQuery()));
	}
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetProductById(int id)
	{
		return NewResult(await mediator.Send(new GetProductByIdQuery(id)));
	}
	[HttpPost]
	public async Task<IActionResult> AddProduct([FromForm] AddProductCommand product)
	{
		return NewResult(await mediator.Send(product));
	}
	[HttpPut]
	public async Task<IActionResult> UpdateProduct([FromForm] UpdateProductCommand product)
	{
		return NewResult(await mediator.Send(product));
	}
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteProduct(int id)
	{
		return NewResult(await mediator.Send(new DeleteProductCommand(id)));
	}
}
