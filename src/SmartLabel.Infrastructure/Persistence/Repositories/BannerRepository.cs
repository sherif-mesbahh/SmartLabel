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
			return await context.Banners
				.AsSplitQuery()
				.AsNoTracking()
				.Include(x => x.Images)
				.ToListAsync();
		}
		public async Task<IEnumerable<Banner?>> GetActiveBanners()
		{
			var currentTime = DateTime.UtcNow;
			return await context.Banners
				.AsSplitQuery()
				.AsNoTracking()
				.Where(x => x.StartDate <= currentTime && currentTime < x.EndDate)
				.Include(x => x.Images)
				.ToListAsync();
		}
		public async Task<Banner?> GetBannerById(int id)
		{
			return await context.Banners
				.Where(x => x.Id == id)
				.Include(x => x.Images)
				.AsNoTracking()
				.AsSplitQuery()
				.FirstOrDefaultAsync();
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

		public async Task AddBannerImage(BannerImage? bannerImage)
		{
			await context.BannerImages.AddAsync(bannerImage);
			await context.SaveChangesAsync();
		}

		public async Task DeleteBannerImage(BannerImage? bannerImage)
		{
			context.BannerImages.Remove(bannerImage);
			await context.SaveChangesAsync();
		}

		public async Task<BannerImage?> GetBannerImageById(int id)
		{
			return await context.BannerImages.FindAsync(id);
		}

		public async Task<bool> IsBannerExist(int id)
		{
			return await context.Banners.AnyAsync(x => x.Id == id);
		}
	}
}
