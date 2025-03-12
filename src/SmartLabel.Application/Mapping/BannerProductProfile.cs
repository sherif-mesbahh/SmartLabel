using AutoMapper;
using SmartLabel.Application.Features.BannerProducts.Command.Models;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping
{
	public class BannerProductProfile : Profile
	{
		public BannerProductProfile()
		{
			CreateMap<AddBannerProductCommand, BannerProduct>();
		}
	}
}
