using Microsoft.AspNetCore.Identity;

namespace SmartLabel.Domain.Entities.Identity;
public class ApplicationUser : IdentityUser<int>
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public ICollection<UserToken> Tokens { get; set; }
}