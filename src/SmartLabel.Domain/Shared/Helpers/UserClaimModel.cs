namespace SmartLabel.Domain.Shared.Helpers;
public class UserClaimModel
{
	public int UserId { get; set; }
	public required string UserName { get; set; }
	public required string Email { get; set; }
}