using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories
{
	public class CategoryRepository(AppDbContext context, IFileService fileService) : ICategoryRepository
	{
		public async Task<IEnumerable<Category?>> GetAllCategory()
		{
			return await context.Categories
				.AsNoTracking()
				.ToListAsync();
		}
		public async Task<Category?> GetCategoryById(int id)
		{
			return await context.Categories
				.Where(x => x.Id == id)
				.Include(x => x.Products)!
				.ThenInclude(x => x.Images)
				.FirstOrDefaultAsync();
		}

		public async Task<string?> GetCategoryImageById(int id)
		{
			return await context.Categories
				.Where(x => x.Id == id)
				.Select(x => x.ImageUrl)
				.FirstOrDefaultAsync();

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
			if (category.ImageUrl is not null) await fileService.DeleteImageAsync(category.ImageUrl);
			context.Categories.Remove(category);
			await context.SaveChangesAsync();
		}

		public async Task<bool> IsCategoryExist(int id)
		{
			return await context.Categories.AnyAsync(x => x.Id == id);
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
