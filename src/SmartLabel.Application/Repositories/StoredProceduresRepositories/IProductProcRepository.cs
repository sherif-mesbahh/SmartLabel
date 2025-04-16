using SmartLabel.Application.Features.Products.Query.Models;
using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Repositories.StoredProceduresRepositories;
public interface IProductProcRepository
{
	Task<(int, IEnumerable<GetAllProductsDto>)> GetAllProductsPaged(GetAllProductsPaginatedQuery query, string? personId);

}
