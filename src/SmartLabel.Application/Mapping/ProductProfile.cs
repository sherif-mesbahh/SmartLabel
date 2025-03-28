using AutoMapper;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping;
public class ProductProfile : Profile
{
	public ProductProfile()
	{
		CreateMap<AddProductCommand, Product>()
			.ForMember(dest => dest.NewPrice,
				opt => opt.MapFrom(src => src.OldPrice - (((decimal)src.Discount / 100) * src.OldPrice)));
		CreateMap<UpdateProductCommand, Product>()
			.ForMember(dest => dest.NewPrice,
				opt => opt.MapFrom(src => src.OldPrice - (((decimal)src.Discount / 100) * src.OldPrice)));
	}
}