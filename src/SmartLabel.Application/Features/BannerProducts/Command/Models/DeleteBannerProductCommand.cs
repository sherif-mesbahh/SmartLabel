using MediatR;

namespace SmartLabel.Application.Features.BannerProducts.Command.Models
{
	public class DeleteBannerProductCommand : IRequest
	{
		public int BannerId { get; set; }
		public int ProductId { get; set; }
		public DeleteBannerProductCommand(int bannerId, int productId)
		{
			BannerId = bannerId;
			ProductId = productId;
		}
	}
}
