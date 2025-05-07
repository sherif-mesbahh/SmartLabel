using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Domain.Entities;
public class Notification
{
	public int Id { get; set; }
	public string Message { get; set; }
	public bool IsRead { get; set; }
	public DateTime CreatedAt { get; set; }
	public int UserId { get; set; }
	public ApplicationUser User { get; set; }
}