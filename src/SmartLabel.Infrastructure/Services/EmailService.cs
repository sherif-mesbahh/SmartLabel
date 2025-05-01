using MailKit.Net.Smtp;
using MimeKit;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Helpers;

namespace SmartLabel.Infrastructure.Services;
public class EmailService(EmailSettings emailSettings) : IEmailService
{
	public async Task Send(string email, string? subject, string? body)
	{
		using var client = new SmtpClient();
		await client.ConnectAsync(emailSettings.Host, emailSettings.Port, emailSettings.UseSSl);
		// To do "Create mail app"
		await client.AuthenticateAsync(emailSettings.FromAddress, emailSettings.Password);
		var bodybuilder = new BodyBuilder
		{
			HtmlBody = $"{body}"
		};
		var message = new MimeMessage
		{
			Body = bodybuilder.ToMessageBody()
		};
		message.From.Add(new MailboxAddress($"{emailSettings.FromName}", emailSettings.FromAddress));
		message.To.Add(MailboxAddress.Parse(email));
		message.Subject = subject ?? "No Subject";
		await client.SendAsync(message);
		await client.DisconnectAsync(true);
	}
}