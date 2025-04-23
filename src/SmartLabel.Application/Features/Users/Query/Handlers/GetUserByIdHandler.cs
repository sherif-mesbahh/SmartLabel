using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Users.Query.Handlers;
public class GetUserByIdHandler(IMapper mapper, UserManager<ApplicationUser> userManager, IHttpContextAccessor httpContextAccessor, IAuthorizationRepository authorizationRepository)
	: ResponseHandler, IRequestHandler<GetUserQuery, Response<GetUserByIdDto>>
{
	public async Task<Response<GetUserByIdDto>> Handle(GetUserQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var existingUser = await userManager.FindByIdAsync(userId!);
		if (existingUser is null)
			return NotFound<GetUserByIdDto>([$"user ID: {userId} not found"], "user discontinued");

		var user = mapper.Map<GetUserByIdDto>(existingUser);
		user.Roles = (List<string>)await authorizationRepository.GetUserRolesAsync(existingUser);
		return Success(user, "User retrieved successfully");
	}
}
