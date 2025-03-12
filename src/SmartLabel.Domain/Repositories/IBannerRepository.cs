using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories
{
	public interface IBannerRepository
	{
		Task<IEnumerable<Banner?>> GetAllBanners();
		Task<IEnumerable<Banner?>> GetActiveBanners();
		Task<Banner?> GetBannerById(int id);
		Task AddBanner(Banner banner);
		Task UpdateBanner(Banner banner);
		Task DeleteBanner(Banner banner);
		Task<bool> IsBannerExist(int id);
	}
}
