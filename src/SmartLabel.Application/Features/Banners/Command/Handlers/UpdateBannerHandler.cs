using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers
{
	public class UpdateBannerHandler(IMapper mapper, IBannerRepository repository, IFileService fileService) : ResponseHandler, IRequestHandler<UpdateBannerCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(UpdateBannerCommand request, CancellationToken cancellationToken)
		{
			if (request.RemovedImageIds != null)
			{
				foreach (var imageId in request.RemovedImageIds)
				{
					var bannerImage = await repository.GetBannerImageById(imageId);
					if (bannerImage is null) continue;
					await fileService.DeleteImageAsync(bannerImage.ImageUrl);
					await repository.DeleteBannerImage(bannerImage);
				}
			}
			var banner = mapper.Map<Banner>(request);
			await repository.UpdateBanner(banner);
			if (request.ImagesFiles is not null)
			{
				foreach (var image in request.ImagesFiles)
				{
					var bannerImage = new BannerImage()
					{
						Id = 0,
						ImageUrl = await fileService.BuildImageAsync(image),
						BannerId = banner.Id
					};
					await repository.AddBannerImage(bannerImage);
				}
			}
			return Updated<string>("Banner is Updated successfully");
		}
	}
}
