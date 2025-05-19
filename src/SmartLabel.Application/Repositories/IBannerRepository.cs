using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Domain.Entities;
using GetBannerByIdDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannerByIdDto;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Application.Repositories;
public interface IBannerRepository
{
	Task<IEnumerable<GetBannersDto?>> GetAllBannersAsync();
	Task<IEnumerable<GetBannersDto?>> GetActiveBannersAsync();
	Task<IEnumerable<GetBannersToActiveDTO>> GetBannersToActiveAsync();
	Task<GetBannerByIdDto?> GetBannerByIdAsync(int id);
	Task AddBannerAsync(Banner banner);
	Task UpdateBannerAsync(int bannerId, Banner banner, string mainImage);
	Task NotifiedBannersAsync(IEnumerable<int> ids);
	Task DeleteBannerAsync(int bannerId);
	Task AddBannerImagesAsync(List<BannerImage> bannerImages);
	Task<List<string?>> GetBannerImageUrlsByIdsAsync(List<int> imageIds);
	Task<string?> GetBannerImage(int id);
	Task DeleteBannerImagesAsync(List<int> imageIds);
	Task<bool> IsBannerExistAsync(int id);
}
