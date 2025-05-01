namespace SmartLabel.Domain.Helpers;
public class EmailSettings
{
	public string Host { get; set; } = null!;
	public int Port { get; set; }
	public string FromAddress { get; set; } = null!;
	public string Password { get; set; } = null!;
	public string FromName { get; set; } = null!;
	public bool UseSSl { get; set; }
}