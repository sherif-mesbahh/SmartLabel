using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Helpers;
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
		var accessToken = await GetAccessToken(user);
		var refreshToken = GenerateRefreshToken();
		await SaveRefreshTokenAsync(user.Id, refreshToken);
		return (accessToken, refreshToken);
	}

	private async Task<string> GetAccessToken(ApplicationUser user)
	{
		var claims = new List<Claim>()
		{
				new Claim(nameof(UserClaimModel.UserId), user.Id.ToString()),
				new Claim(nameof(UserClaimModel.UserName), user.UserName!),
				new Claim(nameof(UserClaimModel.Email), user.Email!)
		};
		var signingCredentials = new SigningCredentials(
			new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SigningKey)),
			SecurityAlgorithms.HmacSha256);

		var jwtToken = new JwtSecurityToken(
			issuer: jwtSettings.Issuer,
			audience: jwtSettings.Audience,
			claims: claims,
			expires: DateTime.UtcNow.AddDays(2),
			signingCredentials: signingCredentials);

		return await Task.FromResult(new JwtSecurityTokenHandler().WriteToken(jwtToken));
	}

	public async Task Logout(int userId)
	{
		var token = await context.UserTokens.FirstOrDefaultAsync(x => x.UserId == userId);
		var userToken = await context.UserTokens.FirstOrDefaultAsync(x => x.RefreshToken == token!.RefreshToken && x.UserId == token.UserId);
		if (userToken is null)
			throw new SecurityTokenException("Refresh token not found");

		await RevokeRefreshToken(userToken.RefreshToken);
	}
	public async Task<(string, string)> RefreshToken(string accessToken, string refreshToken)
	{
		// Validate expired access token (skip lifetime check)
		var principal = ValidateTokenAndGetPrincipleFromExpiredToken(accessToken);
		var userId = principal.FindFirst(nameof(UserClaimModel.UserId))?.Value;

		if (string.IsNullOrEmpty(userId))
			throw new SecurityTokenException("Invalid token");

		// Validate refresh token
		if (!await IsRefreshTokenValid(userId, refreshToken))
			throw new SecurityTokenException("Invalid refresh token");
		// Revoke the old refresh token
		await RevokeRefreshToken(refreshToken);

		//Generate new access token and refresh token
		var user = await context.Users.FindAsync(int.Parse(userId));

		return await GetJwtToken(user!);
	}

	private ClaimsPrincipal ValidateTokenAndGetPrincipleFromExpiredToken(string accessToken)
	{
		var tokenValidationParameters = new TokenValidationParameters()
		{
			ValidateLifetime = false,
			ValidateIssuer = jwtSettings.ValidateIssuer,
			ValidIssuer = jwtSettings.Issuer,
			ValidateAudience = jwtSettings.ValidateAudience,
			ValidAudience = jwtSettings.Audience,
			ValidateIssuerSigningKey = jwtSettings.ValidateSigningKey,
			IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SigningKey))
		};

		var handler = new JwtSecurityTokenHandler();
		var principal = handler.ValidateToken(accessToken, tokenValidationParameters, out var securityToken);

		if (securityToken is not JwtSecurityToken jwtSecurityToken ||
			!jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256, StringComparison.InvariantCultureIgnoreCase))
		{
			throw new SecurityTokenException("Invalid token");
		}

		return principal;
	}

	private async Task<bool> IsRefreshTokenValid(string userId, string refreshToken)
	{
		var userToken = await context.UserTokens
			.FirstOrDefaultAsync(x => x.UserId.ToString() == userId && x.RefreshToken == refreshToken);

		return userToken != null && userToken.ExpiryDate > DateTime.UtcNow;
	}


	private async Task RevokeRefreshToken(string refreshToken)
	{
		var token = await context.UserTokens.FirstOrDefaultAsync(x => x.RefreshToken == refreshToken);
		context.UserTokens.Remove(token!);
		await context.SaveChangesAsync();
	}

	public async Task SaveRefreshTokenAsync(int userId, string refreshToken)
	{
		var userToken = new UserToken
		{
			UserId = userId,
			RefreshToken = refreshToken,
			ExpiryDate = DateTime.UtcNow.AddMonths(2)
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
