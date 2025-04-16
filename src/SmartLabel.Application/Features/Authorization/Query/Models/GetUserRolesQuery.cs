using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authorization.Query.Models;
public class GetUserRolesQuery(string email) : IRequest<Response<IEnumerable<string>>>
{
	public string Email = email;
}
