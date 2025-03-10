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
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetProductById(int id)
	{
		var allProducts = await mediator.Send(new GetProductByIdQuery(id));
		return NewResult(allProducts);
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
}
