using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.Categories;
using SmartLabel.Domain.Shared.Results.Products;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class CategoryRepository(AppDbContext context) : ICategoryRepository
{
	public async Task<IEnumerable<GetAllCategoriesDto?>> GetAllCategoriesAsync()
	{
		return await context.Categories
			.AsNoTracking()
			.Select(c => new GetAllCategoriesDto()
			{
				Name = c.Name,
				ImageUrl = c.ImageUrl
			}).ToListAsync();
	}
	public async Task<GetCategoryByIdDto?> GetCategoryByIdAsync(int id)
	{
		return await context.Categories
			.Where(x => x.Id == id)
			.Select(c => new GetCategoryByIdDto()
			{
				Name = c.Name,
				ImageUrl = c.ImageUrl,
				Products = c.Products
					.Select(p => new GetAllProductsDto()
					{
						Name = p.Name,
						CategoryName = p.Category.Name,
						Discount = p.Discount,
						OldPrice = p.OldPrice,
						NewPrice = p.NewPrice,
						ImageUrl = p.Images!
							.Select(pi => pi.ImageUrl)
							.FirstOrDefault()
					}).ToList()
			}).FirstOrDefaultAsync();
	}

	public async Task AddCategoryAsync(Category category)
	{
		await context.Categories.AddAsync(category);
	}

	public async Task UpdateCategoryAsync(int categoryId, Category category)
	{
		await context.Categories
			.Where(x => x.Id == categoryId)
			.ExecuteUpdateAsync(setters => setters
				.SetProperty(c => c.Name, category.Name)
				.SetProperty(c => c.ImageUrl, category.ImageUrl)
			);
	}
	public async Task DeleteCategoryAsync(int categoryId)
	{
		await context.Categories
			.Where(x => x.Id == categoryId)
			.ExecuteDeleteAsync();
	}

	public async Task<string?> GetCategoryImageByIdAsync(int id)
	{
		return await context.Categories
			.Where(x => x.Id == id)
			.Select(x => x.ImageUrl)
			.FirstOrDefaultAsync();
	}

	public async Task<bool> IsCategoryExistAsync(int id)
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
