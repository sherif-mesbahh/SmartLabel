namespace SmartLabel.Application.Features.Users.Query.Results;
public class GetUserByIdResult
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public string UserName { get; set; }
	public string Email { get; set; }
	public string PasswordHash { get; set; }
}