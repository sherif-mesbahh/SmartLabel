using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.ProductImages.Command.Models;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Features.Products.Command.Results;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Presentation.Base;
using SmartLabel.Presentation.Services;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ProductController(IMediator mediator, IFileService fileService) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllProducts()
	{
		var allProducts = await mediator.Send(new GetAllProductsQuery());
		return NewResult(allProducts);
	}
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetProductById(int id)
	{
		var product = await mediator.Send(new GetProductByIdQuery(id));
		return NewResult(product);
	}
	[HttpPost]
	public async Task<IActionResult> AddProduct([FromForm] AddProductResult product)
	{
		var addedProduct = await mediator.Send(new AddProductCommand(product));
		if (product.ImagesFiles is not null)
		{
			foreach (var imageFile in product.ImagesFiles)
			{
				var productImage = new ProductImage()
				{
					Id = 0,
					ImageUrl = await fileService.BuildImage(imageFile),
					ProductId = addedProduct.Data.Id
				};
				await mediator.Send(new AddProductImageCommand(productImage));
			}
		}
		return NewResult(addedProduct);
	}
	[HttpPut]
	public async Task<IActionResult> UpdateProduct([FromForm] UpdateProductResult product)
	{
		var pro = await mediator.Send(new GetProductByIdQuery(product.Id));
		if (pro.Data.Images is not null)
		{
			foreach (var image in pro.Data.Images)
			{
				await mediator.Send(new DeleteProductImageCommand(image.Id));
				fileService.DeleteImage(image.ImageUrl);
			}
		}
		if (product.ImagesFiles is not null)
		{
			foreach (var imageFile in product.ImagesFiles)
			{
				var productImage = new ProductImage()
				{
					Id = 0,
					ImageUrl = await fileService.BuildImage(imageFile),
					ProductId = product.Id
				};
				await mediator.Send(new AddProductImageCommand(productImage));
			}
		}
		var productResult = await mediator.Send(new UpdateProductCommand(product));
		return NewResult(productResult);
	}
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteProduct(int id)
	{
		var product = await mediator.Send(new GetProductByIdQuery(id));
		if (product.Data.Images is not null)
		{
			foreach (var image in product.Data.Images)
			{
				fileService.DeleteImage(image.ImageUrl);
			}
		}
		var res = await mediator.Send(new DeleteProductCommand(id));
		return NewResult(res);
	}
}
