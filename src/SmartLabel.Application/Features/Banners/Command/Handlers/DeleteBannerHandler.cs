using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers
{
	public class DeleteBannerHandler(IBannerRepository repository, IFileService fileService) : ResponseHandler, IRequestHandler<DeleteBannerCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(DeleteBannerCommand request, CancellationToken cancellationToken)
		{
			var banner = await repository.GetBannerById(request.Id);
			if (banner?.Images is not null)
			{
				foreach (var image in banner.Images)
				{
					await fileService.DeleteImageAsync(image.ImageUrl);
				}
			}
			await repository.DeleteBanner(banner);
			return Deleted<string>("This banner is deleted Successfully");
		}
	}
}
