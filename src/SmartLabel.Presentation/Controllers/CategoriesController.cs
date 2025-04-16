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
public class CategoriesController(ISender sender) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllCategories()
	{
		return NewResult(await sender.Send(new GetAllCategoryQuery()));
	}

	[HttpGet("paginated")]
	public async Task<IActionResult> GetAllCategoriesPaginated([FromQuery] GetAllCategoriesPaginatedQuery query)
	{
		return Ok(await sender.Send(query));
	}

	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetCategoryById(int id)
	{
		var res = await sender.Send(new GetCategoryByIdQuery(id));
		return NewResult(res);
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpPost]
	public async Task<IActionResult> AddCategory([FromForm] AddCategoryCommand category)
	{
		return NewResult(await sender.Send(category));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpPut]
	public async Task<IActionResult> UpdateCategory([FromForm] UpdateCategoryCommand category)
	{
		return NewResult(await sender.Send(category));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteCategory(int id)
	{
		return NewResult(await sender.Send(new DeleteCategoryCommand(id)));
	}
}