using AutoMapper;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping
{
	public class BannerProfile : Profile
	{
		public BannerProfile()
		{
			CreateMap<AddBannerCommand, Banner>();
			CreateMap<UpdateBannerCommand, Banner>();
			CreateMap<Banner, GetBannerResult>();
			CreateMap<Banner, GetBannerByIdResult>();
		}
	}
}
