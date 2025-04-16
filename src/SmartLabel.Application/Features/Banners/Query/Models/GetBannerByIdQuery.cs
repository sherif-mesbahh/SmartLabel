using MediatR;
using SmartLabel.Application.Bases;
using GetBannerByIdDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannerByIdDto;

namespace SmartLabel.Application.Features.Banners.Query.Models;
public class GetBannerByIdQuery(int id) : IRequest<Response<GetBannerByIdDto>>
{
	public int Id = id;
}