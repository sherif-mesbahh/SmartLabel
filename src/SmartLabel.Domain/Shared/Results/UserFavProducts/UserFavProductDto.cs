namespace SmartLabel.Domain.Shared.Results.UserFavProducts;
public class UserFavProductDto
{
	public string? Name { get; set; }
	public decimal? OldPrice { get; set; }
	public decimal? Discount { get; set; }
	public decimal? NewPrice { get; set; }
	public string? CategoryName { get; set; }
	public string? ProductImageUrl { get; set; }
}
