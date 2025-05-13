namespace SmartLabel.Application.Features.Authentication.Command.Results;

public class CreateEmail
{
	public string Email { get; set; }
	public string Subject { get; set; }
	public string Body { get; set; }
}