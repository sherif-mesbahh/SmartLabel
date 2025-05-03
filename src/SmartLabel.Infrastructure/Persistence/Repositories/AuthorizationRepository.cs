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

	public async Task UpdateRoleAsync(int roleId, string newName)
	{
		await context.Roles
			.Where(x => x.Id == roleId)
			.ExecuteUpdateAsync(setters => setters
				.SetProperty(x => x.Name, newName));
	}

	public async Task<IdentityResult> DeleteRoleAsync(int roleId)
	{
		var role = await roleManager.FindByIdAsync(roleId.ToString());
		var result = await roleManager.DeleteAsync(role);
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
	public async Task<bool> IsRoleExistByName(string name)
	{
		return await roleManager.RoleExistsAsync(name);
	}
	public async Task<Role?> GetRoleByName(string name)
	{
		var role = await roleManager.FindByNameAsync(name);
		return role;
	}
	public async Task<bool> IsRoleExistById(int roleId)
	{
		return await roleManager.FindByIdAsync(roleId.ToString()) is not null;
	}
}
