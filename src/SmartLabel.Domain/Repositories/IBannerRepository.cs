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
		Task AddBannerImage(BannerImage? bannerImage);
		Task DeleteBannerImage(BannerImage? bannerImage);
		Task<BannerImage?> GetBannerImageById(int id);
		Task<bool> IsBannerExist(int id);
	}
}
