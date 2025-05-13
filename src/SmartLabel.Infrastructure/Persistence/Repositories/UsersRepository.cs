using Dapper;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;

namespace SmartLabel.Infrastructure.Persistence.Repositories;
public class UsersRepository(ISqlConnectionFactory sqlConnectionFactory) : IUsersRepository
{
	public async Task<IEnumerable<GetAllUsersDto>> GetAllUsersAsync()
	{
		var sqlQuery = """
		               SELECT 
		               u.FirstName,
		               u.LastName,
		               u.Email,
		               r.Name
		               FROM AspNetUsers u
		               INNER JOIN AspNetUserRoles ur
		               ON u.Id = ur.UserId
		               INNER JOIN AspNetRoles r
		               ON ur.RoleId = r.Id
		               """;
		var connection = sqlConnectionFactory.Create();
		var result = connection.QueryAsync<GetAllUsersDto, string, GetAllUsersDto>
		(
			sqlQuery,
			(user, role) =>
			{
				if (role is not null)
				{
					user.Roles ??= new List<string>();
					user.Roles?.Add(role);
				}

				return user;
			},
			splitOn: "Name"
		);
		return await result;
	}

	public async Task<IEnumerable<int>> GetUserIdsAsync()
	{
		using var connection = sqlConnectionFactory.Create();
		var sqlQuery = """
		               SELECT Id
		               FROM AspNetUsers
		               WHERE EmailConfirmed = 1
		               """;
		var userIds = await connection.QueryAsync<int>(sqlQuery);
		return userIds;
	}
}