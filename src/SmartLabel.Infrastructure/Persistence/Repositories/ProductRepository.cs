using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class ProductRepository(AppDbContext context) : IProductRepository
{
	public async Task<IEnumerable<Product?>> GetAllProducts()
	{
		return await context.Products
			.Include(x => x.Category)
			.Include(x => x.Images)
			.AsNoTracking()
			.AsSplitQuery()
			.ToListAsync();
	}

	public async Task<Product?> GetProductById(int id)
	{
		return await context.Products
			.Where(x => x.Id == id)
			.Include(x => x.Category)
			.Include(x => x.Images)
			.AsNoTracking()
			.AsSplitQuery()
			.FirstOrDefaultAsync();
	}
	public async Task AddProduct(Product product)
	{
		await context.Products.AddAsync(product);
	}
	public async Task AddProductImage(ProductImage? productImage)
	{

		await context.ProductImages.AddAsync(productImage);
	}
	public void UpdateProduct(Product product)
	{
		context.Products.Update(product);
	}

	public void DeleteProduct(Product product)
	{
		context.Products.Remove(product);
	}
	public void DeleteProductImage(ProductImage? productImage)
	{
		context.ProductImages.Remove(productImage);
	}

	public async Task<ProductImage?> GetProductImageById(int id)
	{
		return await context.ProductImages.FindAsync(id);
	}

	public async Task<bool> IsProductExist(int id)
	{
		return await context.Products.AnyAsync(x => x.Id == id);
	}

	public async Task<bool> IsProductNameExist(string name, CancellationToken cancellationToken)
	{
		return await context.Products.
			AnyAsync(c => c.Name == name, cancellationToken);
	}

	public async Task<bool> IsProductNameAndIdExist(int id, string name, CancellationToken cancellationToken)
	{
		return await context.Products
			.AnyAsync(c => c.Name == name && c.Id != id, cancellationToken);
	}
}