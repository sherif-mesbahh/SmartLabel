using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class DeleteCategoryHandler(ICategoryRepository repository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<DeleteCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
	{
		if (!await repository.IsCategoryExist(request.Id))
		{
			return NotFound<string>($"The category with id {request.Id} is not found");
		}

		try
		{
			var category = await repository.GetCategoryById(request.Id);
			if (category!.ImageUrl is not null) await fileService.DeleteImageAsync(category.ImageUrl);
			repository.DeleteCategory(category);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			return Deleted<string>("This category is deleted Successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}