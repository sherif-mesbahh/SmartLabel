using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Domain.Repositories;
public interface IAuthenticationRepository
{
	Task<(string, string)> GetJwtToken(ApplicationUser user);
	Task SaveRefreshTokenAsync(int userId, string refreshToken);
	Task Logout(string refreshToken);
	Task<(string, string)> RefreshToken(string accessToken, string refreshToken);
}
