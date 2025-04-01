using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authorization.Command.Models;
public class UpdateUserToRoleCommand : IRequest<Response<string>>
{
	public string Email { get; set; }
	public string RoleName { get; set; }
}
