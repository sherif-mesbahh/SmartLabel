using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Authorization.Command.Handlers;
public class UpdateRoleHandler(IAuthorizationRepository authorizationRepository) : ResponseHandler, IRequestHandler<UpdateRoleCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateRoleCommand request, CancellationToken cancellationToken)
	{
		if (!await authorizationRepository.IsRoleExist(request.OldName))
			return NotFound<string>([$"Role with name {request.OldName} not found"], "Role not exist");

		try
		{
			await authorizationRepository.UpdateRoleAsync(request.OldName, request.NewName);
			return NoContent<string>("Role updated successfully");
		}
		catch (Exception ex)
		{
			var errors = new List<string> { ex.Message };
			return BadRequest<string>(
				message: "Role update failed",
				errors: errors);
		}
	}
}
