using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Shared.Results.Banners;

namespace SmartLabel.Domain.Repositories;
public interface IBannerRepository
{
	Task<IEnumerable<GetBannersDto?>> GetAllBannersAsync();
	Task<IEnumerable<GetBannersDto?>> GetActiveBannersAsync();
	Task<GetBannerByIdDto?> GetBannerByIdAsync(int id);
	Task AddBannerAsync(Banner banner);
	Task UpdateBannerAsync(int bannerId, Banner banner);
	Task DeleteBannerAsync(int bannerId);
	Task AddBannerImagesAsync(List<BannerImage> bannerImages);
	Task<List<string?>> GetBannerImageUrlsByIdsAsync(List<int> imageIds);
	Task DeleteBannerImagesAsync(List<int> imageIds);
	Task<bool> IsBannerExistAsync(int id);
}
