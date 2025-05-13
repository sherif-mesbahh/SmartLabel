using AutoMapper;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping;
public class BannerProfile : Profile
{
	public BannerProfile()
	{
		var currentTime = DateTime.Now;
		CreateMap<AddBannerCommand, Banner>();
		//.ForMember(dest => dest.IsActive, src => src.MapFrom(x => (x.StartDate <= currentTime) && (currentTime <= x.EndDate)));
		CreateMap<UpdateBannerCommand, Banner>();
		//.ForMember(dest => dest.IsActive, src => src.MapFrom(x => (x.StartDate <= currentTime) && (currentTime <= x.EndDate)));
	}
}