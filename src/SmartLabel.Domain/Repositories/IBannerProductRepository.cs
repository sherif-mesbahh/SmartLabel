using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories
{
	public interface IBannerProductRepository
	{
		Task<IEnumerable<BannerProduct?>> GetAllBannerProducts();
		Task<BannerProduct?> GetBannerProductById(int bannerId, int productId);
		Task AddBannerProduct(BannerProduct bannerProduct);
		Task UpdateBannerProduct(BannerProduct bannerProduct);
		Task DeleteBannerProduct(int bannerId, int productId);
		Task<bool> IsBannerProductExist(int bannerId, int productId);
	}
}
