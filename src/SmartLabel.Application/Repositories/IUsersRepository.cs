using SmartLabel.Application.Features.Users.Query.Results;

namespace SmartLabel.Application.Repositories;
public interface IUsersRepository
{
	public Task<IEnumerable<GetAllUsersDto>> GetAllUsersAsync();
}