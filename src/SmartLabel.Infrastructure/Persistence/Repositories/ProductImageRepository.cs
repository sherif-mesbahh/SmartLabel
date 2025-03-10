using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories
{
	public class ProductImageRepository(AppDbContext context) : IProductImageRepository
	{
		public async Task<IEnumerable<ProductImage?>> GetAllProductImages()
		{
			return await context.ProductImages.AsNoTracking().ToListAsync();
		}

		public async Task<ProductImage?> GetProductImageById(int id)
		{
			return await context.ProductImages.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id);
		}

		public async Task AddProductImage(ProductImage productImage)
		{
			await context.ProductImages.AddAsync(productImage);
			await context.SaveChangesAsync();
		}

		public async Task UpdateProductImage(ProductImage productImage)
		{
			context.ProductImages.Update(productImage);
			await context.SaveChangesAsync();
		}

		public async Task DeleteProductImage(ProductImage productImage)
		{
			context.ProductImages.Remove(productImage);
			await context.SaveChangesAsync();
		}

		public async Task<bool> IsProductImage(int id)
		{
			return await context.ProductImages.AnyAsync(x => x.Id == id);
		}
	}
}
