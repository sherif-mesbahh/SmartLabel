using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.JsonWebTokens;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Features.Authentication.Command.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using SmartLabel.Infrastructure.Persistence.Data;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class AuthenticationRepository(JwtSettings jwtSettings, AppDbContext context, UserManager<ApplicationUser> userManager) : IAuthenticationRepository
{
	public async Task<GetTokensDto> GetJwtTokenAsync(ApplicationUser user)
	{
		var accessToken = await GetAccessToken(user);
		var refreshToken = GenerateRefreshToken();
		await SaveRefreshTokenAsync(user.Id, refreshToken);
		var authResponse = new GetTokensDto()
		{
			AccessToken = accessToken,
			RefreshToken = refreshToken
		};
		return authResponse;
	}

	private async Task<string> GetAccessToken(ApplicationUser user)
	{
		var roles = await userManager.GetRolesAsync(user);
		var claims = new ClaimsIdentity(
		[
			new Claim(nameof(UserClaimModel.UserId), user.Id.ToString()),
			new Claim(nameof(UserClaimModel.UserName), user.UserName!),
			new Claim(nameof(UserClaimModel.Email), user.Email!),
		]);
		foreach (var role in roles)
		{
			claims.AddClaim(new Claim(ClaimTypes.Role, role));
		}
		var signingCredentials = new SigningCredentials(
			new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SigningKey!)),
			SecurityAlgorithms.HmacSha256);

		var jwtToken = new SecurityTokenDescriptor
		{
			Issuer = jwtSettings.Issuer,
			Audience = jwtSettings.Audience,
			Subject = claims,
			Expires = DateTime.UtcNow.AddMinutes(jwtSettings.ExpirationInMinutes),
			SigningCredentials = signingCredentials
		};
		return await Task.FromResult(new JsonWebTokenHandler().CreateToken(jwtToken));
	}


	public async Task<GetTokensDto> RefreshTokenAsync(string refreshToken)
	{
		var userToken = await context.UserTokens.FirstOrDefaultAsync(x => x.RefreshToken == refreshToken);
		if (userToken is null || userToken!.ExpiryDate < DateTime.UtcNow)
			throw new SecurityTokenException("The refresh token has expired");

		userToken.RefreshToken = GenerateRefreshToken();
		userToken.ExpiryDate = DateTime.UtcNow.AddMonths(1);
		await context.SaveChangesAsync();
		var user = await userManager.FindByIdAsync(userToken.UserId.ToString());
		var authResponse = new GetTokensDto()
		{
			AccessToken = await GetAccessToken(user!),
			RefreshToken = userToken.RefreshToken
		};
		return authResponse;
	}

	public async Task RevokeRefreshTokenAsync(int userId)
	{
		await context.UserTokens
			.Where(x => x.UserId == userId)
			.ExecuteDeleteAsync();
	}
	private async Task SaveRefreshTokenAsync(int userId, string refreshToken)
	{
		var userToken = new UserToken
		{
			Id = 0,
			UserId = userId,
			RefreshToken = refreshToken,
			ExpiryDate = DateTime.UtcNow.AddMonths(1)
		};
		await context.UserTokens.AddAsync(userToken);
		await context.SaveChangesAsync();
	}

	private string GenerateRefreshToken()
	{
		var randomNumber = new byte[32];
		using var rng = RandomNumberGenerator.Create();
		rng.GetBytes(randomNumber);
		return Convert.ToBase64String(randomNumber);
	}
}
