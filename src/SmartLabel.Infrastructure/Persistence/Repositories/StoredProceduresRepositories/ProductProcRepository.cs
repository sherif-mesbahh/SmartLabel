using Dapper;
using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Domain.Services;
using System.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories.StoredProceduresRepositories;
public class ProductProcRepository(ISqlConnectionFactory sqlConnectionFactory, IUserFavProductRepository userFavProduct) : IProductProcRepository
{
	public async Task<(int, IEnumerable<GetAllProductsDto>)> GetAllProductsPaged(GetAllProductsPaginatedQuery query, string? personId)
	{
		int userId = 0;
		if (personId != null) userId = int.Parse(personId);

		using var connection = sqlConnectionFactory.Create();
		var result = await connection.QueryMultipleAsync("GetProductsPaginated",
			new { query.Search, query.SortColumn, query.SortOrder, query.PageNumber, query.PageSize, userId }, commandType: CommandType.StoredProcedure);
		var countProducts = await result.ReadAsync<int>();
		var totalCount = countProducts.First();
		var products = await result.ReadAsync<GetAllProductsDto>();
		return (totalCount, products);
	}
}
