using AutoMapper;
using MediatR;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class AddBannerHandler(IMapper mapper, IBannerRepository bannerRepository, IMemoryCache memoryCache,
	INotificationRepository notificationRepository, IFileService fileService,
	INotifierService notifierService, IUsersRepository usersRepository, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<AddBannerCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddBannerCommand request, CancellationToken cancellationToken)
	{
		using var transaction = await unitOfWork.BeginTransaction();
		try
		{
			var banner = mapper.Map<Banner>(request);
			if (request.MainImage is not null) banner.MainImage = await fileService.BuildImageAsync(request.MainImage);
			await bannerRepository.AddBannerAsync(banner);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			if (request.ImagesFiles is not null)
			{
				var bannerImages = new List<BannerImage>();
				foreach (var image in request.ImagesFiles)
				{

					var bannerImage = new BannerImage()
					{
						Id = 0,
						ImageUrl = await fileService.BuildImageAsync(image),
						BannerId = banner.Id
					};
					bannerImages.Add(bannerImage);
				}
				await bannerRepository.AddBannerImagesAsync(bannerImages);
			}
			var message = "New banner has been added";
			await unitOfWork.SaveChangesAsync(cancellationToken);
			var userIds = await usersRepository.GetUserIdsAsync();
			await notificationRepository.AddNotificationToUsers(message, userIds);
			await notifierService.SendToAll(message);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			InvalidCache(banner.Id);
			transaction.Commit();
			return Created<string>($"Banner {banner.Id} created successfully");
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>([ex.Message], "Adding banner temporarily unavailable");
		}
	}
	private void InvalidCache(int id)
	{
		memoryCache.Remove($"Banners");
		memoryCache.Remove($"ActiveBanners");
		memoryCache.Remove($"Banner-{id}");
	}
}
