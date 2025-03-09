using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Categories.Command.Models
{
	public class DeleteCategoryCommand : IRequest<Response<string>>
	{
		public int Id { get; }
		public DeleteCategoryCommand(int id)
		{
			Id = id;
		}
	}
}
