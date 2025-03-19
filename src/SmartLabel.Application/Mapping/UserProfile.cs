using AutoMapper;
using SmartLabel.Application.Features.Users.Command.Models;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Application.Mapping;
public class UserProfile : Profile
{
	public UserProfile()
	{
		CreateMap<AddUserCommand, ApplicationUser>();
	}
}
