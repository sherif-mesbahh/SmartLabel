using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Authorization.Command.Models;
using SmartLabel.Application.Repositories;

namespace SmartLabel.Application.Features.Authorization.Command.Handlers;
public class AddRoleHandler(IAuthorizationRepository authorizationRepository) : ResponseHandler, IRequestHandler<AddRoleCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddRoleCommand request, CancellationToken cancellationToken)
	{
		if (await authorizationRepository.IsRoleExist(request.Name))
			return BadRequest<string>(["Role already exists"], "Role Exists");

		var result = await authorizationRepository.AddRoleAsync(request.Name);
		if (!result.Succeeded)
		{
			var errors = result.Errors
				.Select(e => e.Description)
				.ToList();

			return BadRequest<string>(
				message: "Role creation failed",
				errors: errors);
		}
		return Created<string>("Role created successfully");
	}
}
