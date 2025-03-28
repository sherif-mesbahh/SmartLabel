using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Shared.Results.Products;

namespace SmartLabel.Domain.Repositories;
public interface IProductRepository
{
	Task<IEnumerable<GetAllProductsDto?>> GetAllProductsAsync();
	Task<GetProductByIdDto> GetProductByIdAsync(int id);
	Task AddProductAsync(Product product);
	Task UpdateProductAsync(int productId, Product product);
	Task DeleteProductAsync(int productId);
	Task AddProductImagesAsync(List<ProductImage> productImages);
	Task DeleteProductImagesAsync(List<int> imageIds);
	Task<List<string?>> GetProductImageUrlsByIdsAsync(List<int> imageIds);
	Task<bool> IsProductExistAsync(int id);
	Task<bool> IsProductNameExistAsync(string name, CancellationToken cancellationToken);
	Task<bool> IsProductNameAndIdExistAsync(int id, string name, CancellationToken cancellationToken);
}
