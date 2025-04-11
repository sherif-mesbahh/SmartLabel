using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Query.Handlers;
public class GetUserByIdHandler(IMapper mapper, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetUserQuery, Response<GetUserByIdResult>>
{
	public async Task<Response<GetUserByIdResult>> Handle(GetUserQuery request, CancellationToken cancellationToken)
	{
		var claims = httpContextAccessor.HttpContext?.User;
		if (claims is null)
			return Unauthorized<GetUserByIdResult>("Please login first");

		var existingUser = await userManager.GetUserAsync(claims);
		var user = mapper.Map<GetUserByIdResult>(existingUser);
		return Success(user, "User retrieved successfully");
	}
}
