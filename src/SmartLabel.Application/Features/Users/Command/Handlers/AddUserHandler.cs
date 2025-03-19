using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Command.Handlers;

public class AddUserHandler(IMapper mapper, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<AddUserCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddUserCommand request, CancellationToken cancellationToken)
	{
		var user = mapper.Map<ApplicationUser>(request);
		var result = await userManager.CreateAsync(user, request.Password);
		if (!result.Succeeded)
			return BadRequest<string>(result.Errors.FirstOrDefault().Description);

		return Created<string>("User is added successfully");
	}
}