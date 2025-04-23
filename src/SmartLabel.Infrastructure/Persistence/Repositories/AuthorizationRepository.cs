using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Features.Authorization.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class AuthorizationRepository(AppDbContext context, UserManager<ApplicationUser> userManager, RoleManager<Role> roleManager) : IAuthorizationRepository
{
	public async Task<IdentityResult> AddRoleAsync(string name)
	{
		var result = await roleManager.CreateAsync(new Role { Name = name });
		return result;
	}

	public async Task UpdateRoleAsync(string oldName, string newName)
	{
		await context.Roles
			.Where(x => x.Name == oldName)
			.ExecuteUpdateAsync(setters => setters
				.SetProperty(x => x.Name, newName));
	}

	public async Task<IdentityResult> DeleteRoleAsync(string name)
	{
		var result = await roleManager.DeleteAsync(new Role { Name = name });
		return result;
	}

	public async Task<IEnumerable<GetRoleDto>> GetAllRolesAsync()
	{
		return await roleManager.Roles
			.Select(x => new GetRoleDto()
			{
				Id = x.Id,
				RoleName = x.Name
			}).ToListAsync();
	}

	public async Task<IEnumerable<string>> GetUserRolesAsync(ApplicationUser user)
	{
		return await userManager.GetRolesAsync(user);
	}

	public async Task<IdentityResult> AddUserToRoleAsync(ApplicationUser user, string roleName)
	{
		return await userManager.AddToRoleAsync(user, roleName);
	}

	public async Task RemoveUserFromRoleAsync(ApplicationUser user, string roleName)
	{
		await userManager.RemoveFromRoleAsync(user, roleName);
	}

	public async Task UpdateUserToRoleAsync(ApplicationUser user, string roleName)
	{
		var userRoles = await GetUserRolesAsync(user);
		foreach (var role in userRoles)
		{
			await userManager.RemoveFromRoleAsync(user, role);
		}

		await userManager.AddToRoleAsync(user, roleName);
	}
	public async Task<bool> IsRoleExist(string name)
	{
		return await roleManager.RoleExistsAsync(name);
	}
}
