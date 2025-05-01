using Dapper;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Application.Services;
using SmartLabel.Infrastructure.Persistence.Data;
using System.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories.StoredProceduresRepositories;
public class CategoryProcRepository(AppDbContext context, ISqlConnectionFactory sqlConnectionFactory) : ICategoryProcRepository
{
	public async Task<(int, IEnumerable<GetAllCategoriesDto>)> GetAllCategoriesPaged(GetAllCategoriesPaginatedQuery query)
	{
		using var connection = sqlConnectionFactory.Create();
		var result = await connection.QueryMultipleAsync("GetCategoriesPaginated",
			new { query.Search, query.SortColumn, query.SortOrder, query.PageNumber, query.PageSize }, commandType: CommandType.StoredProcedure);
		var countCategories = await result.ReadAsync<int>();
		var totalCount = countCategories.First();
		var getCategoriesProc = await result.ReadAsync<GetAllCategoriesDto>();
		return (totalCount, getCategoriesProc);

	}
}