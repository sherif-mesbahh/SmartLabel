using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Authorization.Command.Handlers;
public class UpdateRoleHandler(IAuthorizationRepository authorizationRepository) : ResponseHandler, IRequestHandler<UpdateRoleCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateRoleCommand request, CancellationToken cancellationToken)
	{
		if (!await authorizationRepository.IsRoleExistById(request.RoleId))
			return BadRequest<string>([$"Role with id {request.RoleId} is not found"], "Role is not found");

		var role = await authorizationRepository.GetRoleByName(request.NewName);
		if (role is not null && role.Id != request.RoleId)
			return BadRequest<string>(["Role already exists"], "Role Exists");

		try
		{
			await authorizationRepository.UpdateRoleAsync(request.RoleId, request.NewName);
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
