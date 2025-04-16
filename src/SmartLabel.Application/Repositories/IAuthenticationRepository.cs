using SmartLabel.Application.Features.Authentication.Command.Results;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Repositories;
public interface IAuthenticationRepository
{
	Task<GetTokensDto> GetJwtTokenAsync(ApplicationUser user);
	Task<GetTokensDto> RefreshTokenAsync(string refreshToken);
	Task RevokeRefreshTokenAsync(int userId);
}
