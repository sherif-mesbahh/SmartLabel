using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class AddCategoryHandler(IMapper mapper, ICategoryRepository categoryRepository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler,
	IRequestHandler<AddCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddCategoryCommand request, CancellationToken cancellationToken)
	{
		try
		{
			var category = mapper.Map<Category>(request);
			if (request.Image is not null)
				category.ImageUrl = await fileService.BuildImageAsync(request.Image);
			await categoryRepository.AddCategoryAsync(category);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			return Created<string>($"Category {category.Id} created successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Adding category temporarily unavailable");
		}
	}
}