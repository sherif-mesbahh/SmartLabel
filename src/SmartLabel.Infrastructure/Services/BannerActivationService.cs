using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Interfaces;

namespace SmartLabel.Infrastructure.Services;
public class BannerActivationService(IBannerRepository bannerRepository, IServiceProvider services, INotifierService notifierService,
	IUsersRepository usersRepository, INotificationRepository notificationRepository, IUnitOfWork unitOfWork) : BackgroundService
{
	private readonly TimeSpan _checkInterval = TimeSpan.FromMinutes(2);
	protected override async Task ExecuteAsync(CancellationToken stoppingToken)
	{
		while (!stoppingToken.IsCancellationRequested)
		{
			try
			{
				using (var scope = services.CreateScope())
				{
					var bannerIDs = await bannerRepository.GetBannersToActiveAsync();
					foreach (var id in bannerIDs)
					{
						var message = "New banner has been added";
						var userIds = await usersRepository.GetUserIdsAsync();
						await notificationRepository.AddNotificationToUsers(message, userIds, (int)EntityEnum.Banner, id);
						await unitOfWork.SaveChangesAsync(stoppingToken);
						await notifierService.SendToAll(message);
					}
					await bannerRepository.NotifiedBannersAsync(bannerIDs);
				}
			}
			catch (Exception ex)
			{
				throw new Exception(ex.Message);
			}
			await Task.Delay(_checkInterval, stoppingToken);
		}
	}
}