using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Authorization.Command.Handlers;

public class DeleteRoleHandler(IAuthorizationRepository authorizationRepository)
	: ResponseHandler, IRequestHandler<DeleteRoleCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteRoleCommand request, CancellationToken cancellationToken)
	{
		if (!await authorizationRepository.IsRoleExist(request.Name))
			return NotFound<string>([$"Role with name {request.Name} not found"], "Role not exist");
		var result = await authorizationRepository.DeleteRoleAsync(request.Name);
		if (!result.Succeeded)
		{
			var errors = result.Errors
				.Select(e => e.Description)
				.ToList();

			return BadRequest<string>(
				message: "Role deleting failed",
				errors: errors);
		}
		return NoContent<string>($"Role {request.Name} deleted successfully");
	}
}
