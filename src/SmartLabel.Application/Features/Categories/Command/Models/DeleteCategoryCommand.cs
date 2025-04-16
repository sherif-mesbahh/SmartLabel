using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Categories.Command.Models;
public class DeleteCategoryCommand(int id) : IRequest<Response<string>>
{
	public int Id = id;
}
