using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Domain.Repositories;
public interface IAuthenticationRepository
{
	Task<string> GetJwtToken(ApplicationUser user);
}
