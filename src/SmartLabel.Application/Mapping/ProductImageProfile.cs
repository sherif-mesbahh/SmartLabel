using AutoMapper;
using SmartLabel.Application.Features.ProductImages.Command.Models;
using SmartLabel.Application.Features.ProductImages.Query.Results;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping
{
	public class ProductImageProfile : Profile
	{
		public ProductImageProfile()
		{
			CreateMap<AddProductImageCommand, ProductImage>();
			CreateMap<ProductImage, GetProductImage>();
		}
	}
}
