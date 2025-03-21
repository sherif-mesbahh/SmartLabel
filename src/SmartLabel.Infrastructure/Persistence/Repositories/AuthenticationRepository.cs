using Microsoft.IdentityModel.Tokens;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Helpers;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class AuthenticationRepository(JwtSettings jwtSettings) : IAuthenticationRepository
{
	public Task<string> GetJwtToken(ApplicationUser user)
	{
		var claims = new List<Claim>()
		{
			new Claim(nameof(UserClaimModel.UserName), user.UserName),
			new Claim(nameof(UserClaimModel.Email), user.Email)

		};
		var jwtToken = new JwtSecurityToken(
			issuer: jwtSettings.Issuer,
			audience: jwtSettings.Audience,
			claims: claims,
			expires: DateTime.UtcNow.AddMinutes(5),
			signingCredentials: new SigningCredentials(
				new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SigningKey)),
				SecurityAlgorithms.HmacSha256));
		var accessToken = new JwtSecurityTokenHandler().WriteToken(jwtToken);
		return Task.FromResult(accessToken);
	}
}
