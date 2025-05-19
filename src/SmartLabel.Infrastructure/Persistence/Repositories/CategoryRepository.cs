using Dapper;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class CategoryRepository(AppDbContext context, IUserFavProductRepository userFavProduct,
	ISqlConnectionFactory sqlConnectionFactory)
	: ICategoryRepository
{
	public async Task<IEnumerable<GetAllCategoriesDto?>> GetAllCategoriesAsync()
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = "SELECT Id, Name, ImageUrl FROM Categories";
		var categoryResponse = await connection
			.QueryAsync<GetAllCategoriesDto>(sqlQuery);
		return categoryResponse.ToList();
	}

	public IQueryable<Category> GetAllCategoriesPaginated()
	{
		IQueryable<Category> query = context.Categories;
		return query;
	}

	public async Task<GetCategoryByIdDto?> GetCategoryByIdAsync(int id, string? userId)
	{
		using var connection = sqlConnectionFactory.Create();
		Dictionary<int, GetCategoryByIdDto> categoryDictionary = new();

		var sqlQuery = """
		               SELECT 
		                   c.Id AS Id, 
		                   c.Name AS Name, 
		                   c.ImageUrl AS ImageUrl,
		                   p.Id AS Id, 
		                   p.Name AS Name, 
		                   p.Discount AS Discount,
		                   p.OldPrice AS OldPrice, 
		                   p.NewPrice AS NewPrice, 
		                   p.MainImage AS MainImage,
		                   p.Favorite AS Favorite
		               FROM Categories c 
		               LEFT JOIN Products p ON c.Id = p.CatId 
		               WHERE c.Id = @categoryId
		               """;

		var categories = await connection.QueryAsync<GetCategoryByIdDto, GetAllProductsDto, GetCategoryByIdDto>(
			sqlQuery,
			(category, product) =>
			{
				if (!categoryDictionary.TryGetValue(category.Id, out var existingCategory))
				{
					categoryDictionary.Add(category.Id, category);
					existingCategory = category;
				}

				if (product != null)
				{
					existingCategory.Products ??= new List<GetAllProductsDto>();
					existingCategory.Products.Add(product);
				}

				return existingCategory;
			},
			new { categoryId = id },
			splitOn: nameof(GetAllProductsDto.Id)
		);

		var categoryResponse = categoryDictionary.Values.FirstOrDefault();
		if (string.IsNullOrEmpty(userId))
			return categoryResponse;
		var favoriteProducts = await userFavProduct.GetFavProductsByUserAsync(int.Parse(userId));
		var favoriteProductsList = favoriteProducts.ToList();
		var favorites = new Dictionary<int, bool>();
		foreach (var product in favoriteProductsList)
		{
			favorites.Add(product.Id, true);
		}

		if (categoryResponse?.Products != null)
		{
			foreach (var product in categoryResponse.Products)
			{
				if (favorites.ContainsKey(product.Id))
					product.Favorite = true;
			}
		}

		return categoryResponse;
	}

	public async Task AddCategoryAsync(Category category)
	{
		await context.Categories.AddAsync(category);
	}

	public async Task UpdateCategoryAsync(int categoryId, Category category, string imageUrl)
	{
		await context.Categories
			.Where(x => x.Id == categoryId)
			.ExecuteUpdateAsync(setters => setters
				.SetProperty(c => c.Name, category.Name)
				.SetProperty(p => p.ImageUrl, category.ImageUrl ?? imageUrl)
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

	public async Task<bool> IsCategoryExistAsync(int id, CancellationToken cancellationToken)
	{
		return await context.Categories.AnyAsync(x => x.Id == id, cancellationToken);
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
