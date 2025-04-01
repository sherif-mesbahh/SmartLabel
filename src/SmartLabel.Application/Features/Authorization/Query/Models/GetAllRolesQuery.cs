using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Query.Results;

namespace SmartLabel.Application.Features.Authorization.Query.Models;
public class GetAllRolesQuery : IRequest<Response<IEnumerable<GetRoleDto>>>
{
}