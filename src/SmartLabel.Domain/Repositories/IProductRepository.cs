using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories;
public interface IProductRepository
{
	Task<IEnumerable<Product?>> GetAllProducts();
	Task<Product?> GetProductById(int id);
	Task AddProduct(Product product);
	void UpdateProduct(Product product);
	void DeleteProduct(Product product);
	Task AddProductImage(ProductImage? productImage);
	void DeleteProductImage(ProductImage? productImage);
	Task<ProductImage?> GetProductImageById(int id);
	Task<bool> IsProductExist(int id);
	Task<bool> IsProductNameExist(string name, CancellationToken cancellationToken);
	Task<bool> IsProductNameAndIdExist(int id, string name, CancellationToken cancellationToken);
}
