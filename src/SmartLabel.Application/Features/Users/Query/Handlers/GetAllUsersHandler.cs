using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Users.Query.Models;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Features.Users.Query.Handlers;
public class GetAllUsersHandler(IMapper mapper, UserManager<ApplicationUser> userManager) : ResponseHandler, IRequestHandler<GetAllUsersQuery, Response<IEnumerable<GetAllUsersResult>>>
{
	public async Task<Response<IEnumerable<GetAllUsersResult>>> Handle(GetAllUsersQuery request, CancellationToken cancellationToken)
	{
		var users = mapper.Map<IEnumerable<GetAllUsersResult>>(await userManager.Users.ToListAsync(cancellationToken));
		return Success(users, "All Users getting successfully");
	}
}