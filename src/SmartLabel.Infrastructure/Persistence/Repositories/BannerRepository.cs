using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories
{
	public class BannerRepository(AppDbContext context) : IBannerRepository
	{
		public async Task<IEnumerable<Banner?>> GetAllBanners()
		{
			return await context.Banners.AsNoTracking().ToListAsync();
		}

		public async Task<IEnumerable<Banner?>> GetActiveBanners()
		{
			DateTime currentTime = DateTime.UtcNow;
			return await context.Banners.AsNoTracking().Where(x => x.EndDate < currentTime).ToListAsync();
		}

		public async Task<Banner?> GetBannerById(int id)
		{
			return await context.Banners.Include(x => x.BannerProducts)!.ThenInclude(x => x.Product)
				.ThenInclude(x => x.Images).FirstOrDefaultAsync(x => x.Id == id);
		}

		public async Task AddBanner(Banner banner)
		{
			await context.Banners.AddAsync(banner);
			await context.SaveChangesAsync();
		}

		public async Task UpdateBanner(Banner banner)
		{
			context.Banners.Update(banner);
			await context.SaveChangesAsync();

		}

		public async Task DeleteBanner(Banner banner)
		{
			context.Banners.Remove(banner);
			await context.SaveChangesAsync();
		}

		public async Task<bool> IsBannerExist(int id)
		{
			return await context.Banners.AnyAsync(x => x.Id == id);
		}
	}
}
