using Dapper;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Application.Services;
using System.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories.StoredProceduresRepositories;
public class BannerProcRepository(ISqlConnectionFactory sqlConnectionFactory) : IBannerProcRepository
{
	public async Task<(int, IEnumerable<GetBannersDto>)> GetAllBannersPaged(GetAllBannersPaginatedQuery query)
	{
		using var connection = sqlConnectionFactory.Create();
		var result = await connection.QueryMultipleAsync("GetBannersPaginated",
			new { query.Search, query.SortColumn, query.SortOrder, query.PageNumber, query.PageSize }, commandType: CommandType.StoredProcedure);
		var countBanners = await result.ReadAsync<int>();
		var totalCount = countBanners.First();
		var getBannersProc = await result.ReadAsync<GetBannersDto>();
		return (totalCount, getBannersProc);

	}
	public async Task<(int, IEnumerable<GetBannersDto>)> GetActiveBannersPaged(GetActiveBannersPaginatedQuery query)
	{
		using var connection = sqlConnectionFactory.Create();
		var result = await connection.QueryMultipleAsync("GetActiveBannersPaginated",
			new { query.Search, query.SortColumn, query.SortOrder, query.PageNumber, query.PageSize }, commandType: CommandType.StoredProcedure);
		var countBanners = await result.ReadAsync<int>();
		var totalCount = countBanners.First();
		var getBannersProc = await result.ReadAsync<GetBannersDto>();
		return (totalCount, getBannersProc);

	}
}
