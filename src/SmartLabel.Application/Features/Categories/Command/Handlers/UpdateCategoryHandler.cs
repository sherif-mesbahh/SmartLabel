using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class UpdateCategoryHandler(ICategoryRepository repository, IMapper mapper, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler
	, IRequestHandler<UpdateCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateCategoryCommand request,
		CancellationToken cancellationToken)
	{
		if (!await repository.IsCategoryExist(request.Id))
		{
			return NotFound<string>($"The Category with id {request.Id} is not found");
		}

		try
		{
			var category = mapper.Map<Category>(request);
			var imageUrl = await repository.GetCategoryImageById(category.Id);
			if (imageUrl is not null) await fileService.DeleteImageAsync(imageUrl);
			if (request.Image is not null) category.ImageUrl = await fileService.BuildImageAsync(request.Image);
			repository.UpdateCategory(category);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			return Updated<string>("Category is Updated successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}
