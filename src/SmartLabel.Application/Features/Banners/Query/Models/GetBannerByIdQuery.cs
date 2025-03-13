using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Results;

namespace SmartLabel.Application.Features.Banners.Query.Models
{
	public class GetBannerByIdQuery : IRequest<Response<GetBannerByIdResult>>
	{
		public int Id { get; set; }

		public GetBannerByIdQuery(int id)
		{
			Id = id;
		}
	}
}
