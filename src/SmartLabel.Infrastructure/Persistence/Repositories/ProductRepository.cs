using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories
{
	public class ProductRepository(AppDbContext context) : IProductRepository
	{
		public async Task<IEnumerable<Product?>> GetAllProducts()
		{
			return await context.Products.Include(x => x.Images).AsNoTracking().ToListAsync();
		}

		public async Task<Product?> GetProductById(int id)
		{
			return await context.Products.Include(x => x.Images).AsNoTracking().FirstOrDefaultAsync(x => x.Id == id);
		}
		public async Task AddProduct(Product product)
		{
			await context.Products.AddAsync(product);
			await context.SaveChangesAsync();
		}
		public async Task UpdateProduct(Product product)
		{
			try
			{
				context.Products.Update(product);
				await context.SaveChangesAsync();
			}
			catch (Exception ex)
			{
				// Log the exception or handle it appropriately
				Console.WriteLine($"An error occurred: {ex.Message}");
			}
		}

		public async Task DeleteProduct(Product product)
		{
			context.Products.Remove(product);
			await context.SaveChangesAsync();
		}

		public async Task<bool> IsProductExist(int id)
		{
			return await context.Products.AnyAsync(x => x.Id == id);
		}

		public async Task<bool> IsProductNameExist(string name, CancellationToken cancellationToken)
		{
			return await context.Products.AnyAsync(c => c.Name == name, cancellationToken);
		}

		public async Task<bool> IsProductNameAndIdExist(int id, string name, CancellationToken cancellationToken)
		{
			return await context.Products.AnyAsync(c => c.Name == name && c.Id != id, cancellationToken);
		}
	}

}
