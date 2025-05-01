namespace SmartLabel.Application.Services;
public interface IEmailService
{
	public Task Send(string email, string subject, string body);

}