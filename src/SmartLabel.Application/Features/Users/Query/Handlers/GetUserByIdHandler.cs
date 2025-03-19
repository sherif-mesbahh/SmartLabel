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
		var userDb = await userManager.FindByIdAsync(request.Id.ToString());
		if (userDb is null) throw new KeyNotFoundException("User with ID " + request.Id + " not found");
		var user = mapper.Map<GetUserByIdResult>(userDb);
		return Success(user, "User is getting successfully");
	}
}
