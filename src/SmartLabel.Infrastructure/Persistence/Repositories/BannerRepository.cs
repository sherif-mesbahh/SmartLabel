using Dapper;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Services;
using SmartLabel.Infrastructure.Persistence.Data;
using GetBannerByIdDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannerByIdDto;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class BannerRepository(AppDbContext context, ISqlConnectionFactory sqlConnectionFactory) : IBannerRepository
{
	public async Task<IEnumerable<GetBannersDto?>> GetAllBannersAsync()
	{
		//return await context.Banners
		//	.AsNoTracking()
		//	.Select(b => new GetBannersDto()
		//	{
		//		Id = b.Id,
		//		Title = b.Title,
		//		ImageUrl = b.Images.FirstOrDefault().ImageUrl
		//	}).ToListAsync();
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT 
		                   b.Id AS Id, 
		                   b.Title AS Title, 
		                   b.MainImage AS ImageUrl
		               FROM Banners b 
		               """;
		var banners = await connection.QueryAsync<GetBannersDto>(sqlQuery);
		return banners.ToList();
	}

	public IQueryable<Banner> GetAllBannersPaginated()
	{
		IQueryable<Banner> banners = context.Banners;
		return banners;
	}

	public async Task<IEnumerable<GetBannersDto?>> GetActiveBannersAsync()
	{
		var currentTime = DateTime.UtcNow;
		//return await context.Banners
		//	.AsNoTracking()
		//	.Where(x => x.StartDate <= currentTime && currentTime < x.EndDate)
		//	.Select(b => new GetBannersDto()
		//	{
		//		Id = b.Id,
		//		Title = b.Title,
		//		ImageUrl = b.Images.FirstOrDefault().ImageUrl
		//	}).ToListAsync();
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT 
		                   b.Id AS Id, 
		                   b.Title AS Title, 
		                   b.MainImage AS ImageUrl
		               FROM Banners b 
		               WHERE GETUTCDATE() BETWEEN b.StartDate AND b.EndDate
		               """;
		var banners = await connection.QueryAsync<GetBannersDto>(sqlQuery);
		return banners.ToList();
	}
	public async Task<GetBannerByIdDto?> GetBannerByIdAsync(int id)
	{
		//return await context.Banners
		//	.AsNoTracking()
		//	.Where(x => x.Id == id)
		//	.Select(b => new GetBannerByIdDto()
		//	{
		//		Id = b.Id,
		//		Title = b.Title,
		//		Description = b.Description,
		//		StartDate = b.StartDate,
		//		EndDate = b.EndDate,
		//		Images = b.Images.Select(pi => pi.ImageUrl).ToList()
		//	})
		//	.FirstOrDefaultAsync();

		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT 
		                   b.Id AS Id, 
		                   b.Title AS Title, 
		                   b.StartDate AS StartDate,
		                   b.EndDate AS EndDate,
		                   b.MainImage AS MainImage,
		                   b.Description AS Description,
		                   bi.ImageUrl AS x
		               FROM Banners b 
		               LEFT JOIN BannerImages bi ON b.Id = bi.BannerId
		               WHERE b.Id = @bannerId
		               """;
		Dictionary<int, GetBannerByIdDto> bannerDictionary = new();
		var banners = await connection.QueryAsync<GetBannerByIdDto, string, GetBannerByIdDto>
		(
			sqlQuery,
			(banner, bannerImage) =>
			{
				if (!bannerDictionary.TryGetValue(banner.Id, out var existingProduct))
				{
					bannerDictionary.Add(banner.Id, banner);
					existingProduct = banner;
				}

				if (bannerImage != null)
				{
					existingProduct.Images ??= new List<string>();
					existingProduct.Images?.Add(bannerImage);
				}

				return existingProduct;
			},
			new { bannerId = id },
			splitOn: "x"
		);
		var bannerResponse = bannerDictionary.Values.FirstOrDefault();
		return bannerResponse;
	}
	public async Task AddBannerAsync(Banner banner)
	{
		await context.Banners.AddAsync(banner);
	}

	public async Task UpdateBannerAsync(int bannerId, Banner banner)
	{
		await context.Banners
			.Where(x => x.Id == bannerId)
			.ExecuteUpdateAsync(setters => setters
				.SetProperty(x => x.Title, banner.Title)
				.SetProperty(x => x.Description, banner.Description)
				.SetProperty(x => x.StartDate, banner.StartDate)
				.SetProperty(x => x.EndDate, banner.EndDate)
				.SetProperty(x => x.MainImage, banner.MainImage)
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

	public async Task<string?> GetBannerImage(int id)
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT MainImage
		               FROM Banners
		               WHERE Id = @bannerId;
		               """;
		var mainImage = await connection.QueryAsync<string>(sqlQuery, new { bannerId = id });
		return mainImage.FirstOrDefault();
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
