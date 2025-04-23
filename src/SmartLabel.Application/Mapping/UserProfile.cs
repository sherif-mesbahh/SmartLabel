using AutoMapper;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Application.Features.Users.Query.Results;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Mapping;
public class UserProfile : Profile
{
	public UserProfile()
	{
		CreateMap<AddUserCommand, ApplicationUser>()
			.ForMember(dest => dest.UserName,
				src => src.MapFrom(x => x.Email));
		CreateMap<UpdateUserCommand, ApplicationUser>();
		CreateMap<ApplicationUser, GetAllUsersDto>();
		CreateMap<ApplicationUser, GetUserByIdDto>();
	}
}
