using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetBannerByIdHandler(IMapper mapper, IBannerRepository repository) : ResponseHandler, IRequestHandler<GetBannerByIdQuery, Response<GetBannerByIdResult>>
{
	public async Task<Response<GetBannerByIdResult>> Handle(GetBannerByIdQuery request, CancellationToken cancellationToken)
	{
		var ban = await repository.GetBannerById(request.Id);
		if (ban is null)
		{
			throw new KeyNotFoundException("Banner with ID " + request.Id + " not found");
		}
		var banner = mapper.Map<GetBannerByIdResult>(ban);
		return Success(banner, "Banner is getting successfully");
	}
}