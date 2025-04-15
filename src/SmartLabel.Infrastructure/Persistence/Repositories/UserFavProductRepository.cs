using Dapper;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Services;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class UserFavProductRepository(AppDbContext context, ISqlConnectionFactory sqlConnectionFactory) : IUserFavProductRepository
{
	public async Task<IEnumerable<GetAllProductsDto>> GetFavProductsByUserAsync(int userId)
	{
		//return await context.UserFavProducts
		//	.AsNoTracking()
		//	.Where(x => x.UserId == userId)
		//	.Select(ufp => new GetAllProductsDto()
		//	{
		//		Id = ufp.Product.Id,
		//		Name = ufp.Product.Name,
		//		OldPrice = ufp.Product.OldPrice,
		//		Discount = ufp.Product.Discount,
		//		NewPrice = ufp.Product.NewPrice,
		//		CategoryId = ufp.Product.CatId,
		//		ImageUrl = ufp.Product.Images!
		//			.OrderBy(pi => pi.Id)
		//			.Select(pi => pi.ImageUrl)
		//			.FirstOrDefault()
		//	})
		//	.ToListAsync();
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT 
		                   p.Id AS Id, 
		                   p.Name AS Name, 
		                   p.Discount AS Discount,
		                   p.OldPrice AS OldPrice, 
		                   p.NewPrice AS NewPrice,
		                   P.CatId As CategoryId,
		                   p.MainImage AS ImageUrl,
		                   p.Favorite As Favorite
		               FROM UserFavProducts ufp 
		               LEFT JOIN Products p
		               ON ufp.ProductId = p.Id
		               WHERE ufp.UserId = @userID
		               """;
		var products = await connection.QueryAsync<GetAllProductsDto>(sqlQuery, new { userID = userId });
		var productsList = products.ToList();
		foreach (var product in productsList)
		{
			product.Favorite = true;
		}
		return productsList;
	}

	public IQueryable<GetAllProductsDto> GetFavProductsByUserQueryable(int userId)
	{
		var query = context.UserFavProducts
			.AsNoTracking()
			.Where(x => x.UserId == userId)
			.Select(ufp => new GetAllProductsDto()
			{
				Id = ufp.Product.Id,
				Name = ufp.Product.Name,
				OldPrice = ufp.Product.OldPrice,
				Discount = ufp.Product.Discount,
				NewPrice = ufp.Product.NewPrice,
				CategoryId = ufp.Product.CatId,
				MainImage = ufp.Product.Images!
					.OrderBy(pi => pi.Id)
					.Select(pi => pi.ImageUrl)
					.FirstOrDefault()
			});
		return query;
	}

	public async Task AddFavProductAsync(UserFavProduct userFavProduct)
	{
		await context.UserFavProducts.AddAsync(userFavProduct);
		await context.SaveChangesAsync();
	}
	public async Task<UserFavProduct?> GetUserFavProductsAsync(int userId, int productId)
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
