using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Results;

namespace SmartLabel.Application.Features.Users.Query.Models;
public class GetAllUsersQuery : IRequest<Response<IEnumerable<GetAllUsersResult>>>
{
}