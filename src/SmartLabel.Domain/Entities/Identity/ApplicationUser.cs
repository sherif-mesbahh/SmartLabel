using Microsoft.AspNetCore.Identity;

namespace SmartLabel.Domain.Entities.Identity;
public class ApplicationUser : IdentityUser<int>
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public string? Code { get; set; }
	public ICollection<UserToken> Tokens { get; set; }
	public ICollection<UserFavProduct> UsserFavProducts { get; set; }
	public ICollection<UserNotification> UserNotifications { get; set; }
}