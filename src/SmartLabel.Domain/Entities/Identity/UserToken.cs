namespace SmartLabel.Domain.Entities.Identity;
public class UserToken
{
	public int Id { get; set; }
	public string RefreshToken { get; set; }
	public DateTime ExpiryDate { get; set; }
	public int UserId { get; set; }
	public ApplicationUser User { get; set; }
}