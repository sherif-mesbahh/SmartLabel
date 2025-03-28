using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Domain.Shared.Results.Banners;

namespace SmartLabel.Application.Features.Banners.Query.Models;
public class GetBannerByIdQuery(int id) : IRequest<Response<GetBannerByIdDto>>
{
	public int Id = id;
}