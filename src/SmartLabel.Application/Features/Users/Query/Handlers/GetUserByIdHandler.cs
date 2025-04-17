using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Users.Query.Handlers;
public class GetUserByIdHandler(IMapper mapper, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<GetUserQuery, Response<GetUserByIdResult>>
{
	public async Task<Response<GetUserByIdResult>> Handle(GetUserQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var existingUser = await userManager.FindByIdAsync(userId!);
		if (existingUser is null)
			return NotFound<GetUserByIdResult>([$"user ID: {userId} not found"], "user discontinued");

		var user = mapper.Map<GetUserByIdResult>(existingUser);
		return Success(user, "User retrieved successfully");
	}
}
