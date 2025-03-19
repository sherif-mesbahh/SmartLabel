using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Results;

namespace SmartLabel.Application.Features.Categories.Query.Models;
public class GetCategoryByIdQuery(int id) : IRequest<Response<GetCategoryResultById>>
{
	public int Id = id;
}
