using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.Products;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class ProductRepository(AppDbContext context) : IProductRepository
{
	public async Task<IEnumerable<GetAllProductsDto?>> GetAllProductsAsync()
	{
		return await context.Products
			.AsNoTracking()
			.Select(p => new GetAllProductsDto()
			{
				Name = p.Name,
				CategoryName = p.Category.Name,
				Discount = p.Discount,
				OldPrice = p.OldPrice,
				NewPrice = p.NewPrice,
				ImageUrl = p.Images.FirstOrDefault().ImageUrl
			})
			.ToListAsync();
	}

	public async Task<GetProductByIdDto> GetProductByIdAsync(int id)
	{
		return await context.Products
			.AsNoTracking()
			.Where(x => x.Id == id)
			.Select(p => new GetProductByIdDto()
			{
				Name = p.Name,
				CategoryName = p.Category.Name,
				Discount = p.Discount,
				OldPrice = p.OldPrice,
				NewPrice = p.NewPrice,
				Description = p.Description,
				Images = p.Images.Select(pi => pi.ImageUrl).ToList()
			}).FirstOrDefaultAsync();
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
				.SetProperty(p => p.CatId, productId)
				.SetProperty(p => p.Discount, p => p.Discount)
				.SetProperty(p => p.OldPrice, product.OldPrice)
				.SetProperty(p => p.NewPrice, product.NewPrice)
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

	public async Task<bool> IsProductNameAndIdExistAsync(int id, string name, CancellationToken cancellationToken)
	{
		return await context.Products
			.AnyAsync(c => c.Name == name && c.Id != id, cancellationToken);
	}
}