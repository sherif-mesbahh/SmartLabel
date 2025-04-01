using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Query.Handlers;
public class GetUserByIdHandler(IMapper mapper, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<GetUserByIdQuery, Response<GetUserByIdResult>>
{
	public async Task<Response<GetUserByIdResult>> Handle(GetUserByIdQuery request, CancellationToken cancellationToken)
	{
		var existingUser = await userManager.FindByIdAsync(request.Id.ToString());
		if (existingUser is null)
		{
			return NotFound<GetUserByIdResult>(
				message: "User not found",
				errors: [$"User with ID {request.Id} does not exist"]);
		}
		var user = mapper.Map<GetUserByIdResult>(existingUser);
		return Success(user, "User retrieved successfully");
	}
}
