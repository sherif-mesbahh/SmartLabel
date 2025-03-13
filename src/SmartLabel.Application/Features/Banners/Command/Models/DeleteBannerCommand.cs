using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Banners.Command.Models
{
	public class DeleteBannerCommand : IRequest<Response<string>>
	{
		public int Id { get; set; }
		public DeleteBannerCommand(int id)
		{
			Id = id;
		}
	}
}
