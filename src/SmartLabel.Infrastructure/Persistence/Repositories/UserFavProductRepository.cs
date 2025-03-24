using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.SharedResults;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class UserFavProductRepository(AppDbContext context) : IUserFavProductRepository
{
	public async Task<IEnumerable<UserFavProductResult>> GetFavProductsByUser(int userId)
	{
		var res = await context.UserFavProducts
			.Where(x => x.UserId == userId)
			.Select(ufp => new UserFavProductResult()
			{
				Name = ufp.Product.Name,
				OldPrice = ufp.Product.OldPrice,
				Discount = ufp.Product.Discount,
				NewPrice = ufp.Product.NewPrice,
				CategoryName = ufp.Product.Category.Name,
				ProductImageUrl = ufp.Product.Images.FirstOrDefault().ImageUrl
			})
			.ToListAsync();

		return res;
	}
	public async Task AddFavProduct(UserFavProduct userFavProduct)
	{
		await context.UserFavProducts.AddAsync(userFavProduct);
		await context.SaveChangesAsync();
	}

	public async Task<UserFavProduct?> GetUserFavProduct(int userId, int productId)
	{
		return await context.UserFavProducts.FirstOrDefaultAsync(x => x.UserId == userId && x.ProductId == productId);
	}

	public async Task DeleteFavProduct(UserFavProduct userFavProduct)
	{
		context.UserFavProducts.Remove(userFavProduct);
		await context.SaveChangesAsync();
	}
}
