using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class UpdateBannerHandler(IMapper mapper, IBannerRepository repository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<UpdateBannerCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateBannerCommand request, CancellationToken cancellationToken)
	{
		if (!await repository.IsBannerExist(request.Id))
		{
			return NotFound<string>($"The Banner with id {request.Id} is not found");
		}
		using var transaction = await unitOfWork.BeginTransaction();
		try
		{
			if (request.RemovedImageIds != null)
			{
				foreach (var imageId in request.RemovedImageIds)
				{
					var bannerImage = await repository.GetBannerImageById(imageId);
					if (bannerImage is null) continue;
					await fileService.DeleteImageAsync(bannerImage.ImageUrl);
					repository.DeleteBannerImage(bannerImage);
				}
			}

			var banner = mapper.Map<Banner>(request);
			repository.UpdateBanner(banner);
			await unitOfWork.SaveChangesAsync(cancellationToken);
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

			await unitOfWork.SaveChangesAsync(cancellationToken);
			transaction.Commit();
			return Updated<string>("Banner is Updated successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}