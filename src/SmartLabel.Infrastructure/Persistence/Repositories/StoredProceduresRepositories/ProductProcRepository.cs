using Dapper;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Domain.Services;
using System.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories.StoredProceduresRepositories;
public class ProductProcRepository(ISqlConnectionFactory sqlConnectionFactory) : IProductProcRepository
{
	public async Task<(int, IEnumerable<GetAllProductsDto>)> GetAllCategoriesPaged(GetAllProductsPaginatedQuery query)
	{
		using var connection = sqlConnectionFactory.Create();
		var result = await connection.QueryMultipleAsync("GetProductsPaginated",
			new { query.Search, query.SortColumn, query.SortOrder, query.PageNumber, query.PageSize }, commandType: CommandType.StoredProcedure);
		var countProducts = await result.ReadAsync<int>();
		var totalCount = countProducts.First();
		var getProductsProc = await result.ReadAsync<GetAllProductsDto>();
		return (totalCount, getProductsProc);
	}
}
