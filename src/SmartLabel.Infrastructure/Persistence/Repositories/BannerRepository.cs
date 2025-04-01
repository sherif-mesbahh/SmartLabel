using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using SmartLabel.Infrastructure.Persistence.Data;
using GetBannerByIdDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannerByIdDto;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class BannerRepository(AppDbContext context) : IBannerRepository
{
	public async Task<IEnumerable<GetBannersDto?>> GetAllBannersAsync()
	{
		return await context.Banners
			.AsNoTracking()
			.Select(b => new GetBannersDto()
			{
				Title = b.Title,
				ImageUrl = b.Images.FirstOrDefault().ImageUrl
			}).ToListAsync();
	}
	public async Task<IEnumerable<GetBannersDto?>> GetActiveBannersAsync()
	{
		var currentTime = DateTime.UtcNow;
		return await context.Banners
			.AsNoTracking()
			.Where(x => x.StartDate <= currentTime && currentTime < x.EndDate)
			.Select(b => new GetBannersDto()
			{
				Title = b.Title,
				ImageUrl = b.Images.FirstOrDefault().ImageUrl
			}).ToListAsync();
	}
	public async Task<GetBannerByIdDto?> GetBannerByIdAsync(int id)
	{
		return await context.Banners
			.AsNoTracking()
			.Where(x => x.Id == id)
			.Select(b => new GetBannerByIdDto()
			{
				Title = b.Title,
				Description = b.Description,
				StartDate = b.StartDate,
				EndDate = b.EndDate,
				Images = b.Images.Select(pi => pi.ImageUrl).ToList()
			})
			.FirstOrDefaultAsync();
	}
	public async Task AddBannerAsync(Banner banner)
	{
		await context.Banners.AddAsync(banner);
	}

	public async Task UpdateBannerAsync(int bannerIdBanner, Banner banner)
	{
		await context.Banners
			.ExecuteUpdateAsync(setters => setters
				.SetProperty(x => x.Title, banner.Title)
				.SetProperty(x => x.Description, banner.Description)
				.SetProperty(x => x.StartDate, banner.StartDate)
				.SetProperty(x => x.EndDate, banner.EndDate)
			);
	}

	public async Task DeleteBannerAsync(int bannerId)
	{
		await context.Banners
			.Where(x => x.Id == bannerId)
			.ExecuteDeleteAsync();
	}

	public async Task AddBannerImagesAsync(List<BannerImage> bannerImages)
	{
		await context.BannerImages.AddRangeAsync(bannerImages);
	}

	public async Task DeleteBannerImagesAsync(List<int> imageIds)
	{
		await context.BannerImages
			.Where(x => imageIds.Contains(x.Id))
			.ExecuteDeleteAsync();
	}

	public async Task<List<string?>> GetBannerImageUrlsByIdsAsync(List<int> imageIds)
	{
		return await context.BannerImages
			.Where(pi => imageIds.Contains(pi.Id))
			.Select(x => x.ImageUrl)
			.ToListAsync();
	}

	public async Task<bool> IsBannerExistAsync(int id)
	{
		return await context.Banners.AnyAsync(x => x.Id == id);
	}
}
