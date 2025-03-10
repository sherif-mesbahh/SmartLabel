using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class DeleteCategoryHandler(ICategoryRepository repository) : ResponseHandler
	, IRequestHandler<DeleteCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
	{
		var category = await repository.GetCategoryById(request.Id);
		await repository.DeleteCategory(category);
		return Deleted<string>("This category is deleted Successfully");
	}
}