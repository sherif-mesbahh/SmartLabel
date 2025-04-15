using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;

namespace SmartLabel.Application.Repositories.StoredProceduresRepositories;
public interface IUserProductsProcRepository
{
	Task<(int, IEnumerable<GetAllProductsDto>)> GetUserProductsPaged(GetFavProductsPaginatedByUserQuery query, int userId);

}
