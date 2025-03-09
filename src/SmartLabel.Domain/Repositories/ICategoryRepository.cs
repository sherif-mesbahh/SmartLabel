using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories
{
	public interface ICategoryRepository
	{
		Task<IEnumerable<Category?>> GetAllCategory();
		Task<Category?> GetCategoryById(int id);
		Task AddCategory(Category category);
		Task UpdateCategory(Category category);
		Task DeleteCategory(Category category);
		Task<bool> IsCategoryExist(int id);
		Task<bool> IsCategoryNameExist(string name, CancellationToken cancellationToken);
		Task<bool> IsCategoryNameAndIdExist(int id, string name, CancellationToken cancellationToken);
	}
}
