using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Domain.Shared.Results.Categories;

namespace SmartLabel.Application.Features.Categories.Query.Models;
public class GetAllCategoryQuery : IRequest<Response<IEnumerable<GetAllCategoriesDto?>>>
{

}

