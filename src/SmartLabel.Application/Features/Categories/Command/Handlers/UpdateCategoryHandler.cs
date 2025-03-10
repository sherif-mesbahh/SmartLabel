using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class UpdateCategoryHandler(ICategoryRepository repository, IMapper mapper) : ResponseHandler
	, IRequestHandler<UpdateCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateCategoryCommand request,
		CancellationToken cancellationToken)
	{
		var category = mapper.Map<Category>(request);
		await repository.UpdateCategory(category);
		return Updated<string>("Category is Updated successfully");
	}
}
