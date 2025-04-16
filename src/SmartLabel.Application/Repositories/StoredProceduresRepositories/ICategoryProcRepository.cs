using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;

namespace SmartLabel.Application.Repositories.StoredProceduresRepositories;
public interface ICategoryProcRepository
{
	Task<(int, IEnumerable<GetAllCategoriesDto>)> GetAllCategoriesPaged(GetAllCategoriesPaginatedQuery query);
}
