using MediatR;
using SmartLabel.Application.Bases;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Application.Features.Banners.Query.Models;
public class GetAllBannersQuery : IRequest<Response<IEnumerable<GetBannersDto?>>>
{
}
