using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories
{
	public interface IProductImageRepository
	{
		Task<IEnumerable<ProductImage?>> GetAllProductImages();
		Task<ProductImage?> GetProductImageById(int id);
		Task AddProductImage(ProductImage productImage);
		Task UpdateProductImage(ProductImage productImage);
		Task DeleteProductImage(ProductImage productImage);
		Task<bool> IsProductImage(int id);
	}
}
