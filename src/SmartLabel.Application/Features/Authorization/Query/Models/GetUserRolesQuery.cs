using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authorization.Query.Models;
public class GetUserRolesQuery(int id) : IRequest<Response<IEnumerable<string>>>
{
	public int Id = id;
}
