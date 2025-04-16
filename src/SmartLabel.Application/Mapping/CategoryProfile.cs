using AutoMapper;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping;
public class CategoryProfile : Profile
{
	public CategoryProfile()
	{
		CreateMap<AddCategoryCommand, Category>();
		CreateMap<UpdateCategoryCommand, Category>();
	}
}
