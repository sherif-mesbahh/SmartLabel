using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authorization.Command.Models;
public class DeleteRoleCommand : IRequest<Response<string>>
{
	public string Name { get; set; }
}
