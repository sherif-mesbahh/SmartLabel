
namespace SmartLabel.Application.Features.Authentication.Command.Results;

public class GetTokensDto
{
	public required string AccessToken { get; set; }
	public required string RefreshToken { get; set; }
}