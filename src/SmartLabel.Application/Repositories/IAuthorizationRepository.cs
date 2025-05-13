using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Features.Authorization.Query.Results;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Repositories;
public interface IAuthorizationRepository
{
	Task<IdentityResult> AddRoleAsync(string name);
	Task UpdateRoleAsync(int roleId, string newName);
	Task<IdentityResult> DeleteRoleAsync(int roleId);
	Task<IEnumerable<GetRoleDto>> GetAllRolesAsync();
	Task<IEnumerable<string>> GetUserRolesAsync(ApplicationUser user);
	Task<IdentityResult> AddUserToRoleAsync(ApplicationUser user, string roleName);
	Task RemoveUserFromRoleAsync(ApplicationUser user, string roleName);
	Task UpdateUserToRoleAsync(ApplicationUser user, string roleName);
	Task<bool> IsRoleExistByName(string name);
	Task<Role?> GetRoleByName(string name);
	Task<bool> IsRoleExistById(int roleId);
}
