using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;
[Route("api/[controller]")]
[ApiController]
public class CategoryController(IMediator mediator) : AppControllerBase
{
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet]
	public async Task<IActionResult> GetAllCategories()
	{
		return NewResult(await mediator.Send(new GetAllCategoryQuery()));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetCategoryById(int id)
	{
		var res = await mediator.Send(new GetCategoryByIdQuery(id));
		return NewResult(res);
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpPost]
	public async Task<IActionResult> AddCategory([FromForm] AddCategoryCommand category)
	{
		return NewResult(await mediator.Send(category));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpPut]
	public async Task<IActionResult> UpdateCategory([FromForm] UpdateCategoryCommand category)
	{
		return NewResult(await mediator.Send(category));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteCategory(int id)
	{
		return NewResult(await mediator.Send(new DeleteCategoryCommand(id)));
	}
}