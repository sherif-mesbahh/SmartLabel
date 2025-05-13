namespace SmartLabel.Application.Features.Users.Query.Results;
public class GetUserByIdDto
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public string Email { get; set; }
	public string PasswordHash { get; set; }
	public List<string> Roles { get; set; }
}