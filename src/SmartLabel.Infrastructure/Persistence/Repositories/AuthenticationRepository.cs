using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Helpers;
using SmartLabel.Infrastructure.Persistence.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class AuthenticationRepository(JwtSettings jwtSettings, AppDbContext context) : IAuthenticationRepository
{
	public async Task<(string, string)> GetJwtToken(ApplicationUser user)
	{
		return (await GetAccessToken(user), GenerateRefreshToken());
	}

	private async Task<string> GetAccessToken(ApplicationUser user)
	{
		var claims = new List<Claim>()
		{
			new Claim(nameof(UserClaimModel.UserId), user.Id.ToString()),
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
		return await Task.FromResult(accessToken);
	}


	public async Task<(string, string)> RefreshToken(string accessToken, string refreshToken)
	{
		//validate accessToken
		var claimPrincipal = ValidateTokenAndGetPrincipleFromExpiredToken(accessToken);
		var userId = claimPrincipal.FindFirst(nameof(UserClaimModel.UserId))?.Value;
		var user = await context.Users.FindAsync(int.Parse(userId!));
		var expClaim = claimPrincipal.FindFirst(c => c.Type == "exp")?.Value;
		var expiredTime = DateTimeOffset.FromUnixTimeSeconds(long.Parse(expClaim!)).UtcDateTime;
		if (expiredTime > DateTime.UtcNow) throw new SecurityTokenException("Token is not expired");
		//validate user is found or not
		if (user is null) throw new SecurityTokenException("Invalid token");
		//validate refresh token
		if (!await IsRefreshTokenValid(userId, refreshToken)) throw new SecurityTokenException("Invalid token");
		return (await GetAccessToken(user), refreshToken);
	}
	private ClaimsPrincipal ValidateTokenAndGetPrincipleFromExpiredToken(string token)
	{
		var tokenValidationParameters = new TokenValidationParameters()
		{
			ValidateLifetime = jwtSettings.ValidateLifetime,
			ValidateIssuer = jwtSettings.ValidateIssuer,
			ValidIssuer = jwtSettings.Issuer,
			ValidateAudience = jwtSettings.ValidateAudience,
			ValidAudience = jwtSettings.Audience,
			ValidateIssuerSigningKey = jwtSettings.ValidateSigningKey,
			IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SigningKey))
		};
		try
		{
			var claimPrincipal =
				new JwtSecurityTokenHandler().ValidateToken(token, tokenValidationParameters, out var securityToken);
			if (securityToken is not JwtSecurityToken jwtSecurityToken ||
				!jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256,
					StringComparison.InvariantCultureIgnoreCase))
				throw new SecurityTokenException("Invalid token");
			return claimPrincipal;
		}
		catch (Exception ex)
		{
			throw new SecurityTokenException(ex.Message);
		}
	}

	private async Task<bool> IsRefreshTokenValid(string userId, string refreshToken)
	{
		var userToken = await context.UserTokens
			.FirstOrDefaultAsync(x => x.UserId.ToString() == userId && x.RefreshToken == refreshToken);

		if (userToken == null) return false;

		if (userToken.ExpiryDate < DateTime.UtcNow)
		{
			context.UserTokens.Remove(userToken);
			await context.SaveChangesAsync();
			return false;
		}
		return true;
	}
	public async Task SaveRefreshTokenAsync(int userId, string refreshToken)
	{
		var userToken = new UserToken
		{
			UserId = userId,
			RefreshToken = refreshToken,
			ExpiryDate = DateTime.UtcNow.AddDays(7)
		};

		await context.UserTokens.AddAsync(userToken);
		await context.SaveChangesAsync();
	}
	public string GenerateRefreshToken()
	{
		var randomNumber = new byte[32];
		using var rng = RandomNumberGenerator.Create();
		rng.GetBytes(randomNumber);
		return Convert.ToBase64String(randomNumber);
	}
}
