namespace SmartLabel.Application.Features.Users.Query.Results;
public class GetAllUsersDto
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public string Email { get; set; }
	public List<string>? Roles { get; set; } = new List<string>();
}
