using SmartLabel.Domain.Entities;
using UserFavProductDto = SmartLabel.Application.Features.UserFavProducts.Query.Results.UserFavProductDto;

namespace SmartLabel.Application.Repositories;
public interface IUserFavProductRepository
{
	Task<IEnumerable<UserFavProductDto>> GetFavProductsByUserAsync(int userId);
	Task AddFavProductAsync(UserFavProduct userFavProduct);
	Task<UserFavProduct?> GetUserFavProductAsync(int userId, int productId);
	Task<bool> IsFavoriteExistAsync(int userId, int productId);
	Task DeleteFavProductAsync(int id);
}