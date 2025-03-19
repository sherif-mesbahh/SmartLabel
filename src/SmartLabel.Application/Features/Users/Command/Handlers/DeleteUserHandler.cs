using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class DeleteUserHandler(UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<DeleteUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
	{
		var userDb = await userManager.FindByIdAsync(request.Id.ToString());
		if (userDb is null)
			return NotFound<string>($"The User with id {request.Id} is not found");
		await userManager.DeleteAsync(userDb);
		return Deleted<string>("This User is deleted Successfully");
	}
}
