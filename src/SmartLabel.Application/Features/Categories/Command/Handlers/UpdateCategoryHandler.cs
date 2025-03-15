using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class UpdateCategoryHandler(ICategoryRepository repository, IMapper mapper, IFileService fileService) : ResponseHandler
	, IRequestHandler<UpdateCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateCategoryCommand request,
		CancellationToken cancellationToken)
	{
		var category = mapper.Map<Category>(request);
		var imageUrl = await repository.GetCategoryImageById(category.Id);
		if (imageUrl is not null) await fileService.DeleteImageAsync(imageUrl);
		if (request.Image is not null) category.ImageUrl = await fileService.BuildImageAsync(request.Image);
		await repository.UpdateCategory(category);
		return Updated<string>("Category is Updated successfully");
	}
}
