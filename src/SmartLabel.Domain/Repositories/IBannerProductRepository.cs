using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories
{
	public interface IBannerProductRepository
	{
		Task<IEnumerable<BannerProduct?>> GetAllBannerProducts();
		Task<BannerProduct?> GetBannerProductById(int id);
		Task AddBannerProduct(BannerProduct bannerProduct);
		Task UpdateBannerProduct(BannerProduct bannerProduct);
		Task DeleteBannerProduct(BannerProduct bannerProduct);
		Task<bool> IsBannerProductExist(int id);
	}
}
