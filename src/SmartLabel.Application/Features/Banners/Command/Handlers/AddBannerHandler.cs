using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers
{
	public class AddBannerHandler(IMapper mapper, IBannerRepository repository, IFileService fileService) : ResponseHandler, IRequestHandler<AddBannerCommand, Response<string>>
	{
		public async Task<Response<string>> Handle(AddBannerCommand request, CancellationToken cancellationToken)
		{
			var banner = mapper.Map<Banner>(request);
			await repository.AddBanner(banner);
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
			return Created<string>("Banner is added successfully");
		}
	}
}
