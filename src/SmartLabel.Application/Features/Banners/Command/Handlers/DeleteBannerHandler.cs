using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.Banners.Command.Handlers
{
	public class DeleteBannerHandler(IBannerRepository repository) : ResponseHandler, IRequestHandler<DeleteBannerCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(DeleteBannerCommand request, CancellationToken cancellationToken)
		{
			var banner = await repository.GetBannerById(request.Id);
			await repository.DeleteBanner(banner);
			return Deleted<string>("This Banner is deleted Successfully");
		}
	}
}
