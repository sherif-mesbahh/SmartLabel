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

		public async Task<BannerProduct?> GetBannerProductById(int bannerId, int productId)
		{
			return await context.BannerProducts.FirstOrDefaultAsync(x => x.ProductId == productId && x.BannerId == bannerId);
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

		public async Task DeleteBannerProduct(int bannerId, int productId)
		{

			context.BannerProducts.Remove(await GetBannerProductById(bannerId, productId));
			await context.SaveChangesAsync();
		}

		public Task<bool> IsBannerProductExist(int bannerId, int productId)
		{
			return context.BannerProducts.AnyAsync(x => x.BannerId == bannerId && x.ProductId == productId);
		}
	}
}
