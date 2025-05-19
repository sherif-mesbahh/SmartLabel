namespace SmartLabel.Application.Services;
public interface IEmailService
{
	public Task Send(string email, string subject, string Url, string Urn);
	public string PrepareUrl(int userId, string code);
}