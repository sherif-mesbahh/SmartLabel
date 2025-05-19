using MailKit.Net.Smtp;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using MimeKit;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Helpers;
using System.Net;

namespace SmartLabel.Infrastructure.Services;
public class EmailService(EmailSettings emailSettings, IHttpContextAccessor httpContextAccessor, IWebHostEnvironment env) : IEmailService
{
	public string PrepareUrl(int userId, string code)
	{
		var httpContext = httpContextAccessor.HttpContext;
		var scheme = httpContext?.Request.Scheme;
		var host = httpContext?.Request.Host;
		var encodedCode = WebUtility.UrlEncode(code);
		var url = $"{scheme}://{host}/api/Authentication/confirm-email?UserId={userId}&Code={encodedCode}";
		return url;
	}

	public async Task Send(string email, string? subject, string Url, string Urn)
	{
		using var client = new SmtpClient();
		await client.ConnectAsync(emailSettings.Host, emailSettings.Port, emailSettings.UseSSl);
		await client.AuthenticateAsync(emailSettings.FromAddress, emailSettings.Password);
		string path = Path.Combine(env.WebRootPath, "Uploads", Urn);
		string emailBody = await File.ReadAllTextAsync(path);
		emailBody = emailBody.Replace("{{Link}}", Url);
		var bodybuilder = new BodyBuilder
		{
			HtmlBody = emailBody
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

	public async Task SendToResetPassword(string email, string subject, string code)
	{
		using var client = new SmtpClient();
		await client.ConnectAsync(emailSettings.Host, emailSettings.Port, emailSettings.UseSSl);
		await client.AuthenticateAsync(emailSettings.FromAddress, emailSettings.Password);
		string path = Path.Combine(env.WebRootPath, "Uploads", "reset-password.html");
		string emailBody = await File.ReadAllTextAsync(path);
		emailBody = emailBody.Replace("{{RESET_CODE}}", code);
		var bodybuilder = new BodyBuilder
		{
			HtmlBody = emailBody
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