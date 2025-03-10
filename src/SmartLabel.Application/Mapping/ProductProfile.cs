using AutoMapper;
using SmartLabel.Application.Features.Products.Command.Models;
using SmartLabel.Application.Features.Products.Query.Results;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping
{
	public class ProductProfile : Profile
	{
		public ProductProfile()
		{
			CreateMap<AddProductCommand, Product>();
			CreateMap<Product, GetProductByIdResult>();
			CreateMap<GetProductByIdResult, Product>();
		}
	}
}
