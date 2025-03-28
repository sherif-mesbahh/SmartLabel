using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Domain.Shared.Results.Categories;

namespace SmartLabel.Application.Features.Categories.Query.Models;
public class GetCategoryByIdQuery(int id) : IRequest<Response<GetCategoryByIdDto>>
{
	public int Id = id;
}
