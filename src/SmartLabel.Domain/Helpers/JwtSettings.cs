namespace SmartLabel.Domain.Helpers;
public class JwtSettings
{
	public string? Issuer { get; set; }
	public string? Audience { get; set; }
	public string? SigningKey { get; set; }
	public bool ValidateIssuer { get; set; }
	public bool ValidateAudience { get; set; }
	public bool ValidateSigningKey { get; set; }
	public bool ValidateLifetime { get; set; }
	public int ExpirationInMinutes { get; set; }
}
