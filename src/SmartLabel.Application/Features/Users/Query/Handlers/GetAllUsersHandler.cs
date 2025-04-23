using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Users.Query.Handlers;
public class GetAllUsersHandler(IMapper mapper, IUsersRepository users) : ResponseHandler, IRequestHandler<GetAllUsersQuery, Response<IEnumerable<GetAllUsersDto>>>
{
	public async Task<Response<IEnumerable<GetAllUsersDto>>> Handle(GetAllUsersQuery request, CancellationToken cancellationToken)
	{
		var allUsers = await users.GetAllUsersAsync();
		return Success(allUsers, "All Users retrieved successfully");
	}
}