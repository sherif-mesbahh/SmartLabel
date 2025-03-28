using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class DeleteCategoryHandler(ICategoryRepository categoryRepository, IFileService fileService)
	: ResponseHandler, IRequestHandler<DeleteCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
	{
		if (!await categoryRepository.IsCategoryExistAsync(request.Id))
		{
			return NotFound<string>($"The category with id {request.Id} is not found");
		}

		try
		{
			var categoryImage = await categoryRepository.GetCategoryImageByIdAsync(request.Id);
			if (categoryImage is not null) await fileService.DeleteImageAsync(categoryImage);
			await categoryRepository.DeleteCategoryAsync(request.Id);
			return Deleted<string>($"This category with id {request.Id} is deleted Successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}