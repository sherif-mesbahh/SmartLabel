using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authorization.Command.Models;
public class UpdateRoleCommand : IRequest<Response<string>>
{
	public int RoleId { get; set; }
	public string NewName { get; set; }
}
