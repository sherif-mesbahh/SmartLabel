using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class AddCategoryHandler(IMapper mapper, ICategoryRepository repository) : ResponseHandler,
	IRequestHandler<AddCategoryCommand, Response<AddCategoryCommand>>
{
	public async Task<Response<AddCategoryCommand>> Handle(AddCategoryCommand request, CancellationToken cancellationToken)
	{
		var category = mapper.Map<Category>(request);
		await repository.AddCategory(category);
		request.Id = category.Id;
		return Created(request, "Category is added successfully");
	}
}