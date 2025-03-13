using MediatR;

namespace SmartLabel.Application.Features.BannerProducts.Query.Models
{
	public class IsBannerProductExistQuery : IRequest<bool>
	{
		public int BannerId { get; set; }
		public int ProductId { get; set; }
		public IsBannerProductExistQuery(int bannerId, int productId)
		{
			BannerId = bannerId;
			ProductId = productId;
		}
	}
}
