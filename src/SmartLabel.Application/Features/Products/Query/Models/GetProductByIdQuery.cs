using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Domain.Shared.Results.Products;

namespace SmartLabel.Application.Features.Products.Query.Models;
public class GetProductByIdQuery(int id) : IRequest<Response<GetProductByIdDto>>
{
	public int Id = id;
}