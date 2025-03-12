using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Products.Command.Models
{
	public class DeleteProductCommand : IRequest<Response<string>>
	{
		public int Id { get; }
		public DeleteProductCommand(int id)
		{
			Id = id;
		}
	}
}
