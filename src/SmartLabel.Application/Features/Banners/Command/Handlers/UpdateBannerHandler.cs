using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class UpdateBannerHandler(IMapper mapper, IBannerRepository bannerRepository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<UpdateBannerCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateBannerCommand request, CancellationToken cancellationToken)
	{
		if (!await bannerRepository.IsBannerExistAsync(request.Id))
			return NotFound<string>([$"Banner ID: {request.Id} not found"], "Banner discontinued");
		using var transaction = await unitOfWork.BeginTransaction();
		try
		{

			var mainImage = await bannerRepository.GetBannerImage(request.Id);
			if (request.MainImage is not null) await fileService.DeleteImageAsync(mainImage);
			if (request.RemovedImageIds is not null)
			{
				var imageUrls = await bannerRepository.GetBannerImageUrlsByIdsAsync(request.RemovedImageIds);
				foreach (var imageUrl in imageUrls)
				{
					await fileService.DeleteImageAsync(imageUrl);
				}
				await bannerRepository.DeleteBannerImagesAsync(request.RemovedImageIds);
			}
			var banner = mapper.Map<Banner>(request);
			if (request.MainImage is not null) banner.MainImage = await fileService.BuildImageAsync(request.MainImage);
			if (request.ImagesFiles is not null)
			{
				var bannerImages = new List<BannerImage>();
				foreach (var image in request.ImagesFiles)
				{
					var imageUrl = await fileService.BuildImageAsync(image);
					var bannerImage = new BannerImage()
					{
						Id = 0,
						ImageUrl = imageUrl,
						BannerId = banner.Id
					};
					bannerImages.Add(bannerImage);
				}
				await bannerRepository.AddBannerImagesAsync(bannerImages);
			}
			await unitOfWork.SaveChangesAsync(cancellationToken);
			await bannerRepository.UpdateBannerAsync(banner.Id, banner, mainImage);
			transaction.Commit();
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>([ex.Message], "Updating banner temporarily unavailable");
		}
	}
}