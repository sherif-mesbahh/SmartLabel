using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Features.Categories.Command.Results;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Presentation.Base;
using SmartLabel.Presentation.Services;


namespace SmartLabel.Presentation.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class CategoryController(IMediator mediator, IFileService fileService) : AppControllerBase
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
		public async Task<IActionResult> AddCategory([FromForm] AddCategoryResult category)
		{
			var imageUrl = string.Empty;
			if (category.Image is not null) imageUrl = await fileService.BuildImage(category.Image);
			var categoryResult = await mediator.Send(new AddCategoryCommand(category, imageUrl));
			return NewResult(categoryResult);
		}

		[HttpPut]
		public async Task<IActionResult> UpdateCategory([FromForm] UpdateCategoryResult category)
		{
			var cat = await mediator.Send(new GetCategoryByIdQuery(category.Id));
			if (!cat.Data.ImageUrl.IsNullOrEmpty()) fileService.DeleteImage(cat.Data.ImageUrl);
			var imageUrl = string.Empty;
			if (category.Image is not null) imageUrl = await fileService.BuildImage(category.Image);
			var categoryResult = await mediator.Send(new UpdateCategoryCommand(category, imageUrl));
			return NewResult(categoryResult);
		}

		[HttpDelete("{id:int}")]
		public async Task<IActionResult> DeleteCategory(int id)
		{
			var cat = await mediator.Send(new GetCategoryByIdQuery(id));
			if (!cat.Data.ImageUrl.IsNullOrEmpty())
				fileService.DeleteImage(cat.Data.ImageUrl);
			var res = await mediator.Send(new DeleteCategoryCommand(id));
			return NewResult(res);
		}
	}
}
