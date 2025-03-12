using MediatR;
using SmartLabel.Application.Features.BannerProducts.Command.Results;

namespace SmartLabel.Application.Features.BannerProducts.Command.Models
{
	public class AddBannerProductCommand : IRequest
	{
		public int Id { get; set; }
		public int BannerId { get; set; }
		public int ProductId { get; set; }

		public AddBannerProductCommand(AddBannerProductResult bannerProduct)
		{
			Id = bannerProduct.Id;
			BannerId = bannerProduct.BannerId;
			ProductId = bannerProduct.ProductId;
		}
	}
}
