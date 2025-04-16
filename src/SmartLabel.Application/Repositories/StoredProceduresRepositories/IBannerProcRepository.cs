using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;

namespace SmartLabel.Application.Repositories.StoredProceduresRepositories;
public interface IBannerProcRepository
{
	Task<(int, IEnumerable<GetBannersDto>)> GetAllBannersPaged(GetAllBannersPaginatedQuery query);
	Task<(int, IEnumerable<GetBannersDto>)> GetActiveBannersPaged(GetActiveBannersPaginatedQuery query);
}