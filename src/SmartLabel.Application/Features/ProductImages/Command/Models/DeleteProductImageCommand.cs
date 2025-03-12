using MediatR;

namespace SmartLabel.Application.Features.ProductImages.Command.Models
{
	public class DeleteProductImageCommand : IRequest
	{
		public int Id { get; set; }

		public DeleteProductImageCommand(int id)
		{
			Id = id;
		}
	}
}
