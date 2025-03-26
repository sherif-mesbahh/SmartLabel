using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Route("api/[controller]")]
[ApiController]
public class CategoryController(IMediator mediator) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllCategory()
	{
		var allCategories = await mediator.Send(new GetAllCategoryQuery());
		return NewResult(allCategories);
	}
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetCategoryById(int id)
	{
		var res = await mediator.Send(new GetCategoryByIdQuery(id));
		return NewResult(res);
	}

	[HttpPost]
	public async Task<IActionResult> AddCategory([FromForm] AddCategoryCommand category)
	{
		return NewResult(await mediator.Send(category));
	}

	[HttpPut]
	public async Task<IActionResult> UpdateCategory([FromForm] UpdateCategoryCommand category)
	{
		return NewResult(await mediator.Send(category));
	}

	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteCategory(int id)
	{
		return NewResult(await mediator.Send(new DeleteCategoryCommand(id)));
	}
}