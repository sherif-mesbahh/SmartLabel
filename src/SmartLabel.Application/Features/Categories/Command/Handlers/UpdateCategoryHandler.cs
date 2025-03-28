using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class UpdateCategoryHandler(ICategoryRepository categoryRepository, IMapper mapper, IFileService fileService)
	: ResponseHandler
	, IRequestHandler<UpdateCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateCategoryCommand request,
		CancellationToken cancellationToken)
	{
		if (!await categoryRepository.IsCategoryExistAsync(request.Id))
		{
			return NotFound<string>($"The Category with id {request.Id} is not found");
		}

		try
		{
			var category = mapper.Map<Category>(request);
			var imageUrl = await categoryRepository.GetCategoryImageByIdAsync(category.Id);
			if (imageUrl is not null) await fileService.DeleteImageAsync(imageUrl);
			if (request.Image is not null) category.ImageUrl = await fileService.BuildImageAsync(request.Image);
			await categoryRepository.UpdateCategoryAsync(category.Id, category);
			return Updated<string>($"Category with id {category.Id} is Updated successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"{ex.Message}");
		}
	}
}
