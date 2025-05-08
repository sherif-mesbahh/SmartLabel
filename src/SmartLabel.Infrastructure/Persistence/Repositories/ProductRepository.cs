using Dapper;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class ProductRepository(AppDbContext context, IUserFavProductRepository userFavProduct, ISqlConnectionFactory sqlConnectionFactory) : IProductRepository
{
	public async Task<IEnumerable<GetAllProductsDto?>> GetAllProductsAsync(string? userId)
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT 
		                   p.Id AS Id, 
		                   p.Name AS Name, 
		                   p.Discount AS Discount,
		                   p.OldPrice AS OldPrice, 
		                   p.NewPrice AS NewPrice, 
		                   p.MainImage AS MainIMage,
		                   p.CatId As CategoryId,
		                   p.Favorite AS Favorite
		               FROM Products p 
		               """;
		var products = await connection.QueryAsync<GetAllProductsDto>(sqlQuery);
		var productsList = products.ToList();
		if (string.IsNullOrEmpty(userId))
			return productsList;
		var favoriteProducts = await userFavProduct.GetFavProductsByUserAsync(int.Parse(userId));
		var favoriteProductsList = favoriteProducts.ToList();
		Dictionary<int, bool> favorites = new Dictionary<int, bool>();
		foreach (var product in favoriteProductsList)
		{
			favorites.Add(product.Id, true);
		}

		foreach (var product in productsList)
		{
			if (favorites.ContainsKey(product.Id))
			{
				product.Favorite = true;
			}
		}
		return productsList;
	}

	public IQueryable<Product> GetAllProductsPaginated()
	{
		IQueryable<Product> products = context.Products;
		return products;
	}

	public async Task<GetProductByIdDto?> GetProductByIdAsync(int id)
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT 
		                   p.Id AS Id, 
		                   p.Name AS Name, 
		                   p.Discount AS Discount,
		                   p.OldPrice AS OldPrice, 
		                   p.NewPrice AS NewPrice, 
		                   p.MainImage AS MainImage,
		                   p.Description AS Description,
		                   p.CatId AS CategoryId,
		                   p.Favorite AS Favorite,
		                   pi.ImageUrl AS ImageUrl
		               FROM Products p 
		               LEFT JOIN ProductImages pi ON p.Id = pi.ProductId
		               WHERE p.Id = @productId
		               """;
		Dictionary<int, GetProductByIdDto> productDictionary = new();
		var products = await connection.QueryAsync<GetProductByIdDto, GetProductImageDto, GetProductByIdDto>
		(
			sqlQuery,
			(product, productImage) =>
			{
				if (!productDictionary.TryGetValue(product.Id, out var existingProduct))
				{
					productDictionary.Add(product.Id, product);
					existingProduct = product;
				}

				if (productImage != null)
				{
					existingProduct.Images ??= new List<GetProductImageDto>();
					existingProduct.Images?.Add(productImage);
				}

				return existingProduct;
			},
			new { productId = id },
			splitOn: "ImageUrl"
		);
		var productResponse = productDictionary.Values.FirstOrDefault();
		return productResponse;
	}

	public async Task<GetProductByIdDto?> GetProductByIdUserAsync(int id, string? userId)
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT 
		                   p.Id AS Id, 
		                   p.Name AS Name, 
		                   p.Discount AS Discount,
		                   p.OldPrice AS OldPrice, 
		                   p.NewPrice AS NewPrice, 
		                   p.MainImage AS MainImage,
		                   p.Description AS Description,
		                   p.CatId AS CategoryId,
		                   p.Favorite AS Favorite,
		                   pi.Id AS ImageId,
		                   pi.ImageUrl AS ImageUrl
		               FROM Products p 
		               LEFT JOIN ProductImages pi ON p.Id = pi.ProductId
		               WHERE p.Id = @productId
		               """;
		Dictionary<int, GetProductByIdDto> productDictionary = new();
		var products = await connection.QueryAsync<GetProductByIdDto, GetProductImageDto, GetProductByIdDto>
		(
			sqlQuery,
			(product, productImage) =>
			{
				if (!productDictionary.TryGetValue(product.Id, out var existingProduct))
				{
					productDictionary.Add(product.Id, product);
					existingProduct = product;
				}

				if (productImage != null)
				{
					existingProduct.Images ??= new List<GetProductImageDto>();
					existingProduct.Images?.Add(productImage);
				}

				return existingProduct;
			},
			new { productId = id },
			splitOn: "ImageId"
		);
		var productResponse = productDictionary.Values.FirstOrDefault();
		if (string.IsNullOrEmpty(userId)) return productResponse;
		var favoriteProducts = await userFavProduct.GetFavProductsByUserAsync(int.Parse(userId));
		if (productResponse is not null)
		{
			var ok = favoriteProducts.Select(x => x.Id).Contains(productResponse.Id);
			productResponse.Favorite = ok;
		}
		return productResponse;
	}
	public async Task AddProductAsync(Product product)
	{
		await context.Products.AddAsync(product);
	}
	public async Task AddProductImagesAsync(List<ProductImage> productImages)
	{

		await context.ProductImages.AddRangeAsync(productImages);
	}
	public async Task UpdateProductAsync(int productId, Product product)
	{
		await context.Products
			.Where(x => x.Id == productId)
			.ExecuteUpdateAsync(setters => setters
				.SetProperty(p => p.Name, product.Name)
				.SetProperty(p => p.Description, product.Description)
				.SetProperty(p => p.CatId, product.CatId)
				.SetProperty(p => p.Discount, product.Discount)
				.SetProperty(p => p.OldPrice, product.OldPrice)
				.SetProperty(p => p.NewPrice, product.NewPrice)
				.SetProperty(p => p.MainImage, product.MainImage)
			);
	}

	public async Task DeleteProductAsync(int productId)
	{
		await context.Products.Where(x => x.Id == productId).ExecuteDeleteAsync();
	}
	public async Task DeleteProductImagesAsync(List<int> imageIds)
	{
		await context.ProductImages
			.Where(x => imageIds.Contains(x.Id))
			.ExecuteDeleteAsync();
	}

	public async Task<List<string?>> GetProductImageUrlsByIdsAsync(List<int> imageIds)
	{
		return await context.ProductImages
			.Where(pi => imageIds.Contains(pi.Id))
			.Select(x => x.ImageUrl)
			.ToListAsync();
	}

	public async Task<bool> IsProductExistAsync(int id)
	{
		return await context.Products.AnyAsync(x => x.Id == id);
	}

	public async Task<bool> IsProductNameExistAsync(string name, CancellationToken cancellationToken)
	{
		return await context.Products.
			AnyAsync(c => c.Name == name, cancellationToken);
	}
	public async Task<string?> GetProductImage(int id)
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT MainImage
		               FROM Products
		               WHERE Id = @productId;
		               """;
		var mainImage = await connection.QueryAsync<string>(sqlQuery, new { productId = id });
		return mainImage.FirstOrDefault();
	}

	public async Task<bool> IsProductNameAndIdExistAsync(int id, string name, CancellationToken cancellationToken)
	{
		return await context.Products
			.AnyAsync(c => c.Name == name && c.Id != id, cancellationToken);
	}

	public async Task<decimal> GetProductPriceAsync(int id)
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		                   SELECT NewPrice
		                   FROM Products
		                   WHERE Id = @productId;
		                   """;
		var price = await connection.QueryAsync<decimal>(sqlQuery, new { productId = id });
		return price.First();
	}
}