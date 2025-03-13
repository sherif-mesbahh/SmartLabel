using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.BannerProducts.Query.Models
{
	public class GetBannerProductResult
	{
		public int BannerId { get; set; }
		public int ProductId { get; set; }
		public GetProductByIdResult Product { get; set; }
	}
}
