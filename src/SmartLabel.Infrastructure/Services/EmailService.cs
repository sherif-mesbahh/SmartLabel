using MailKit.Net.Smtp;
using Microsoft.AspNetCore.Http;
using MimeKit;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Helpers;
using System.Net;

namespace SmartLabel.Infrastructure.Services;
public class EmailService(EmailSettings emailSettings, IHttpContextAccessor httpContextAccessor) : IEmailService
{
	public string PrepareUrl(int userId, string code)
	{
		var scheme = httpContextAccessor?.HttpContext?.Request.Scheme;
		var host = httpContextAccessor?.HttpContext?.Request.Host;
		var encodedCode = WebUtility.UrlEncode(code);
		var url = $"{scheme}://{host}/api/Authentication/confirm-email?UserId={userId}&Code={encodedCode}";
		return url;
	}

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