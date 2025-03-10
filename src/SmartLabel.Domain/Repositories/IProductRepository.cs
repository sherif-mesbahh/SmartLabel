using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories
{
	public interface IProductRepository
	{
		Task<IEnumerable<Product?>> GetAllProducts();
		Task<Product?> GetProductById(int id);
		Task AddProduct(Product product);
		Task UpdateProduct(Product product);
		Task DeleteProduct(Product product);
		Task<bool> IsProductExist(int id);
	}
}
