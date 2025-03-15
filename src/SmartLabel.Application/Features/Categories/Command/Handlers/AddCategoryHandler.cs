using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class AddCategoryHandler(IMapper mapper, ICategoryRepository repository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler,
	IRequestHandler<AddCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddCategoryCommand request, CancellationToken cancellationToken)
	{
		try
		{
			var category = mapper.Map<Category>(request);
			if (request.Image is not null) category.ImageUrl = await fileService.BuildImageAsync(request.Image);
			await repository.AddCategory(category);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			return Created<string>("Category is added successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}