using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Repositories;
public interface ICategoryRepository
{
	Task<IEnumerable<GetAllCategoriesDto?>> GetAllCategoriesAsync();
	Task<GetCategoryByIdDto?> GetCategoryByIdAsync(int id, string? userId);
	Task AddCategoryAsync(Category category);
	Task UpdateCategoryAsync(int categoryId, Category category);
	Task DeleteCategoryAsync(int categoryId);
	Task<string?> GetCategoryImageByIdAsync(int id);
	Task<bool> IsCategoryExistAsync(int id);
	Task<bool> IsCategoryNameExist(string name, CancellationToken cancellationToken);
	Task<bool> IsCategoryNameAndIdExist(int id, string name, CancellationToken cancellationToken);
}