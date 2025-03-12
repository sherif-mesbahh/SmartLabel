using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories
{
	public class BannerProductRepository(AppDbContext context) : IBannerProductRepository
	{
		public async Task<IEnumerable<BannerProduct?>> GetAllBannerProducts()
		{
			return await context.BannerProducts.AsNoTracking().ToListAsync();
		}

		public async Task<BannerProduct?> GetBannerProductById(int id)
		{
			return await context.BannerProducts.FirstOrDefaultAsync(x => x.Id == id);
		}

		public async Task AddBannerProduct(BannerProduct bannerProduct)
		{
			await context.BannerProducts.AddAsync(bannerProduct);
			await context.SaveChangesAsync();
		}

		public async Task UpdateBannerProduct(BannerProduct bannerProduct)
		{
			context.BannerProducts.Update(bannerProduct);
			await context.SaveChangesAsync();
		}

		public async Task DeleteBannerProduct(BannerProduct bannerProduct)
		{
			context.BannerProducts.Remove(bannerProduct);
			await context.SaveChangesAsync();
		}

		public Task<bool> IsBannerProductExist(int id)
		{
			return context.BannerProducts.AnyAsync(x => x.Id == id);
		}
	}
}
