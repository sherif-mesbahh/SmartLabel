using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Shared.Results;

namespace SmartLabel.Domain.Repositories;
public interface IUserFavProductRepository
{
	Task<IEnumerable<UserFavProductResult>> GetFavProductsByUser(int userId);
	Task AddFavProduct(UserFavProduct userFavProduct);
	Task<UserFavProduct?> GetUserFavProduct(int userId, int productId);
	Task DeleteFavProduct(UserFavProduct userFavProduct);
}