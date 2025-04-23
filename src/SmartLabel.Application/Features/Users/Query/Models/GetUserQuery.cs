using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Results;

namespace SmartLabel.Application.Features.Users.Query.Models;
public class GetUserQuery() : IRequest<Response<GetUserByIdDto>>
{
}
