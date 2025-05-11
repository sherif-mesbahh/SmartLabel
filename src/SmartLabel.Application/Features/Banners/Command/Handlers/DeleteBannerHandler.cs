using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class DeleteBannerHandler(IBannerRepository bannerRepository, IFileService fileService, IMemoryCache memoryCache)
	: ResponseHandler, IRequestHandler<DeleteBannerCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteBannerCommand request, CancellationToken cancellationToken)
	{
		var banner = await bannerRepository.GetBannerByIdAsync(request.Id);
		if (banner is null)
			return NotFound<string>([$"Banner ID: {request.Id} not found"], "Banner discontinued");
		try
		{
			if (banner.MainImage is not null)
				await fileService.DeleteImageAsync(banner.MainImage);
			if (banner.Images is not null)
			{
				foreach (var image in banner.Images)
					await fileService.DeleteImageAsync(image.ImageUrl);
			}

			await bannerRepository.DeleteBannerAsync(request.Id);
			InvalidCache(request.Id);
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Deleting banner temporarily unavailable");
		}
	}
	private void InvalidCache(int id)
	{
		memoryCache.Remove($"Banners");
		memoryCache.Remove($"ActiveBanners");
		memoryCache.Remove($"Banner-{id}");
	}
}
