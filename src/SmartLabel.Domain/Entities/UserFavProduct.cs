using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Domain.Entities;
public class UserFavProduct
{
	public int Id { get; set; }
	public int UserId { get; set; }
	public int ProductId { get; set; }
	public ApplicationUser User { get; set; }
	public Product Product { get; set; }
}
