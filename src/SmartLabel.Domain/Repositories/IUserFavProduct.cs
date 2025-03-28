using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Shared.Results.UserFavProducts;

namespace SmartLabel.Domain.Repositories;
public interface IUserFavProductRepository
{
	Task<IEnumerable<UserFavProductDto>> GetFavProductsByUserAsync(int userId);
	Task AddFavProductAsync(UserFavProduct userFavProduct);
	Task<UserFavProduct?> GetUserFavProductAsync(int userId, int productId);
	Task DeleteFavProductAsync(int id);
}