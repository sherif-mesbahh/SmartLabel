using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Banners.Query.Handlers
{
	public class GetAllBannersHandler(IMapper mapper, IBannerRepository repository) : ResponseHandler, IRequestHandler<GetAllBannersQuery, Response<IEnumerable<GetBannerResult>>>
	{
		public async Task<Response<IEnumerable<GetBannerResult>>> Handle(GetAllBannersQuery request, CancellationToken cancellationToken)
		{
			var banners = mapper.Map<IEnumerable<GetBannerResult>>(await repository.GetAllBanners());
			return Success(banners, "All Banners getting successfully");
		}
	}
}
