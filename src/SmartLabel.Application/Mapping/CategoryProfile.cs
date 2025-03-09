using AutoMapper;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Features.Categories.Command.Results;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Application.Mapping;
public class CategoryProfile : Profile
{
	public CategoryProfile()
	{
		CreateMap<Category, GetCategoryResultById>();
		CreateMap<Category, GetAllCategoryResult>();
		CreateMap<AddCategoryCommand, Category>();
		CreateMap<UpdateCategoryCommand, Category>();
	}
}
