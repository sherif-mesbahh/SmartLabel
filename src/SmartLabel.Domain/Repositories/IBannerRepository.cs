using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories;
public interface IBannerRepository
{
	Task<IEnumerable<Banner?>> GetAllBanners();
	Task<IEnumerable<Banner?>> GetActiveBanners();
	Task<Banner?> GetBannerById(int id);
	Task AddBanner(Banner banner);
	void UpdateBanner(Banner banner);
	void DeleteBanner(Banner banner);
	Task AddBannerImage(BannerImage? bannerImage);
	void DeleteBannerImage(BannerImage? bannerImage);
	Task<BannerImage?> GetBannerImageById(int id);
	Task<bool> IsBannerExist(int id);
}
