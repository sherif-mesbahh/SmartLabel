using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Products.Command.Models
{
	public class DeleteProductCommand(int id) : IRequest<Response<string>>
	{
		public int Id = id;
	}
}
