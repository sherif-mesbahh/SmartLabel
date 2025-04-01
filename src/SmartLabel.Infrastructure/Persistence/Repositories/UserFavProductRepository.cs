using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using SmartLabel.Infrastructure.Persistence.Data;
using UserFavProductDto = SmartLabel.Application.Features.UserFavProducts.Query.Results.UserFavProductDto;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class UserFavProductRepository(AppDbContext context) : IUserFavProductRepository
{
	public async Task<IEnumerable<UserFavProductDto>> GetFavProductsByUserAsync(int userId)
	{
		return await context.UserFavProducts
			.AsNoTracking()
			.Where(x => x.UserId == userId)
			.Select(ufp => new UserFavProductDto()
			{
				Name = ufp.Product.Name,
				OldPrice = ufp.Product.OldPrice,
				Discount = ufp.Product.Discount,
				NewPrice = ufp.Product.NewPrice,
				CategoryName = ufp.Product.Category.Name,
				ProductImageUrl = ufp.Product.Images!
					.OrderBy(pi => pi.Id)
					.Select(pi => pi.ImageUrl)
					.FirstOrDefault()
			})
			.ToListAsync();
	}
	public async Task AddFavProductAsync(UserFavProduct userFavProduct)
	{
		await context.UserFavProducts.AddAsync(userFavProduct);
		await context.SaveChangesAsync();
	}
	public async Task<UserFavProduct?> GetUserFavProductAsync(int userId, int productId)
	{
		return await context.UserFavProducts
			.FirstOrDefaultAsync(x => x.UserId == userId && x.ProductId == productId);
	}

	public Task<bool> IsFavoriteExistAsync(int userId, int productId)
	{
		return context.UserFavProducts
			.AnyAsync(x => x.UserId == userId && x.ProductId == productId);
	}

	public async Task DeleteFavProductAsync(int id)
	{
		await context.UserFavProducts
			.Where(x => x.Id == id)
			.ExecuteDeleteAsync();
	}
}
