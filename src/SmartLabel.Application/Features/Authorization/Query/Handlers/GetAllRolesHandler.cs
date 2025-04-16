using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Query.Models;
using SmartLabel.Application.Features.Authorization.Query.Results;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Authorization.Query.Handlers;
public class GetAllRolesHandler(IAuthorizationRepository authorizationRepository) : ResponseHandler, IRequestHandler<GetAllRolesQuery, Response<IEnumerable<GetRoleDto>>>
{
	public async Task<Response<IEnumerable<GetRoleDto>>> Handle(GetAllRolesQuery request, CancellationToken cancellationToken)
	{
		return Success(await authorizationRepository.GetAllRolesAsync(), "All roles retrieved successfully");
	}
}
