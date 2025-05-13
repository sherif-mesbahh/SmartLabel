using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[ApiController]
[Route("api/[controller]")]
public class ProductsController(ISender sender) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllProducts()
	{
		return NewResult(await sender.Send(new GetAllProductsQuery()));
	}

	[HttpGet("paginated")]
	public async Task<PagedList<GetAllProductsDto>> GetAllProductsPaginated([FromQuery] GetAllProductsPaginatedQuery query)
	{
		return await sender.Send(query);
	}

	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetProductById(int id)
	{
		return NewResult(await sender.Send(new GetProductByIdQuery(id)));
	}
	[Authorize(Roles = nameof(RolesEnum.Admin))]
	[HttpPost]
	public async Task<IActionResult> AddProduct([FromForm] AddProductCommand product)
	{
		return NewResult(await sender.Send(product));
	}
	[Authorize(Roles = nameof(RolesEnum.Admin))]
	[HttpPut]
	public async Task<IActionResult> UpdateProduct([FromForm] UpdateProductCommand product)
	{
		return NewResult(await sender.Send(product));

	}
	[Authorize(Roles = nameof(RolesEnum.Admin))]
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteProduct(int id)
	{
		return NewResult(await sender.Send(new DeleteProductCommand(id)));
	}
}
