using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Repositories;
using GetBannersDto = SmartLabel.Application.Features.Banners.Query.Results.GetBannersDto;

namespace SmartLabel.Application.Features.Banners.Query.Handlers;
public class GetAllBannersHandler(IBannerRepository repository) : ResponseHandler, IRequestHandler<GetAllBannersQuery, Response<IEnumerable<GetBannersDto?>>>
{
	public async Task<Response<IEnumerable<GetBannersDto?>>> Handle(GetAllBannersQuery request, CancellationToken cancellationToken)
	{
		var banners = await repository.GetAllBannersAsync();
		return Success(banners, "All Banners retrieved successfully");
	}
}