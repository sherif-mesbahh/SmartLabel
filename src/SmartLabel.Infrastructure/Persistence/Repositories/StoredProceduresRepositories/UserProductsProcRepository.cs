using Dapper;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Domain.Services;
using System.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories.StoredProceduresRepositories;
public class UserProductsProcRepository(ISqlConnectionFactory sqlConnectionFactory) : IUserProductsProcRepository
{
	public async Task<(int, IEnumerable<GetAllProductsDto>)> GetUserProductsPaged(GetFavProductsPaginatedByUserQuery query, int userId)
	{
		using var connection = sqlConnectionFactory.Create();
		var result = await connection.QueryMultipleAsync("GetUserProductsPaginated",
			new { query.Search, query.SortColumn, query.SortOrder, query.PageNumber, query.PageSize, userId }, commandType: CommandType.StoredProcedure);
		var countProducts = await result.ReadAsync<int>();
		var totalCount = countProducts.First();
		var getUserProductsProc = await result.ReadAsync<GetAllProductsDto>();
		return (totalCount, getUserProductsProc);
	}
}