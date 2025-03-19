using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Command.Handlers;
public class UpdateUserHandler(IMapper mapper, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<UpdateUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
	{
		var userDb = await userManager.FindByIdAsync(request.Id.ToString());
		if (userDb is null)
			return NotFound<string>($"The User with id {request.Id} is not found");
		var user = mapper.Map(request, userDb);
		var result = await userManager.UpdateAsync(user);
		if (!result.Succeeded)
			return BadRequest<string>(result.Errors.FirstOrDefault().Description);

		return Updated<string>("User is Updated successfully");
	}
}
