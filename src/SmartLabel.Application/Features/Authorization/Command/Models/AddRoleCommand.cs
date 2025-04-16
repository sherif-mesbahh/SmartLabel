using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authorization.Command.Models;
public class AddRoleCommand : IRequest<Response<string>>
{
	public string Name { get; set; }
}
