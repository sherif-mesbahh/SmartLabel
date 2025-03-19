using AutoMapper;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Features.Products.Query.Results;
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
		CreateMap<Product, GetProductByIdResult>()
			.ForMember(dest => dest.CategoryName,
				opt => opt.MapFrom(src => src.Category.Name));
		CreateMap<ProductImage, GetProductImageResult>();
		CreateMap<Product, GetAllProductsResult>()
			.ForMember(dest => dest.CategoryName,
				opt => opt.MapFrom(src => src.Category.Name))
			.ForMember(dest => dest.Image,
				opt => opt.MapFrom(src => src.Images!.FirstOrDefault()));
	}
}