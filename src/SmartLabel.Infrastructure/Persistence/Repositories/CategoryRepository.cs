using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories
{
	public class CategoryRepository(AppDbContext context) : ICategoryRepository
	{
		public async Task<IEnumerable<Category?>> GetAllCategory()
		{
			return await context.Categories.AsNoTracking().ToListAsync();
		}

		public async Task<Category?> GetCategoryById(int id)
		{
			return await context.Categories.Include(x => x.Products).AsNoTracking().FirstOrDefaultAsync(x => x!.Id == id);
		}

		public async Task AddCategory(Category category)
		{
			await context.Categories.AddAsync(category);
			await context.SaveChangesAsync();
		}

		public async Task UpdateCategory(Category category)
		{
			context.Categories.Update(category);
			await context.SaveChangesAsync();
		}

		public async Task DeleteCategory(Category category)
		{
			context.Categories.Remove(category);
			await context.SaveChangesAsync();
		}

		public async Task<bool> IsCategoryExist(int id)
		{
			return await GetCategoryById(id) is null;
		}

		public async Task<bool> IsCategoryNameExist(string name, CancellationToken cancellationToken)
		{
			return await context.Categories.AnyAsync(c => c.Name == name, cancellationToken);
		}

		public async Task<bool> IsCategoryNameAndIdExist(int id, string name, CancellationToken cancellationToken)
		{
			return await context.Categories.AnyAsync(c => c.Name == name && c.Id != id, cancellationToken);
		}
	}
}
