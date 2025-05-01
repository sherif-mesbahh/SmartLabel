using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class DeleteCategoryHandler(ICategoryRepository categoryRepository, IFileService fileService)
	: ResponseHandler, IRequestHandler<DeleteCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
	{
		if (!await categoryRepository.IsCategoryExistAsync(request.Id, cancellationToken))
			return NotFound<string>([$"Category ID: {request.Id} not found"], "Category discontinued");

		try
		{
			var categoryImage = await categoryRepository.GetCategoryImageByIdAsync(request.Id);
			if (categoryImage is not null) await fileService.DeleteImageAsync(categoryImage);
			await categoryRepository.DeleteCategoryAsync(request.Id);
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Deleting category temporarily unavailable");
		}
	}
}