using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.Products.Query.Models
{
	public class GetProductByIdQuery : IRequest<Response<GetProductByIdResult>>
	{
		public int Id { get; set; }

		public GetProductByIdQuery(int id)
		{
			Id = id;
		}
	}
}
