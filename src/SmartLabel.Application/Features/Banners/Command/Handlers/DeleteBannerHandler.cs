using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Interfaces;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class DeleteBannerHandler(IBannerRepository bannerRepository, IFileService fileService, IUnitOfWork unitOfWork)
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
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Deleting banner temporarily unavailable");
		}
	}
}
