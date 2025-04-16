using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Repositories;
public interface IUserFavProductRepository
{
	Task<IEnumerable<GetAllProductsDto>> GetFavProductsByUserAsync(int userId);
	IQueryable<GetAllProductsDto> GetFavProductsByUserQueryable(int userId);
	Task AddFavProductAsync(UserFavProduct userFavProduct);
	Task<UserFavProduct?> GetUserFavProductsAsync(int userId, int productId);
	Task<bool> IsFavoriteExistAsync(int userId, int productId);
	Task DeleteFavProductAsync(int id);
}