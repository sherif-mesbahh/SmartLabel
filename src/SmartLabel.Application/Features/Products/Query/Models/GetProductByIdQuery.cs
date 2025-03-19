using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.Products.Query.Models;
public class GetProductByIdQuery(int id) : IRequest<Response<GetProductByIdResult>>
{
	public int Id = id;
}