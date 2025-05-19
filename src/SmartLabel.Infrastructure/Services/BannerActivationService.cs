using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Interfaces;

namespace SmartLabel.Infrastructure.Services;
public class BannerActivationService(IServiceScopeFactory services) : BackgroundService
{
	private readonly TimeSpan _checkInterval = TimeSpan.FromSeconds(30);
	protected override async Task ExecuteAsync(CancellationToken stoppingToken)
	{
		using PeriodicTimer timer = new(_checkInterval);

		while (!stoppingToken.IsCancellationRequested && await timer.WaitForNextTickAsync(stoppingToken))
		{
			try
			{
				await using (var scope = services.CreateAsyncScope())
				{
					var bannerRepository = scope.ServiceProvider.GetRequiredService<IBannerRepository>();
					var notifierService = scope.ServiceProvider.GetRequiredService<INotifierService>();
					var usersRepository = scope.ServiceProvider.GetRequiredService<IUsersRepository>();
					var memoryCache = scope.ServiceProvider.GetRequiredService<IMemoryCache>();
					var notificationRepository = scope.ServiceProvider.GetRequiredService<INotificationRepository>();
					var unitOfWork = scope.ServiceProvider.GetRequiredService<IUnitOfWork>();

					var objs = await bannerRepository.GetBannersToActiveAsync();
					if (objs.Any()) memoryCache.Remove($"ActiveBanners");
					var bannerIds = new List<int>();
					foreach (var b in objs)
					{
						var message = "New banner has been added";
						var userIds = await usersRepository.GetUserIdsAsync();
						await notificationRepository.AddNotificationToUsers(message, userIds, (int)EntityEnum.Banner, b.Id, b.Image);
						bannerIds.Add(b.Id);
						await unitOfWork.SaveChangesAsync(stoppingToken);
						await notifierService.SendToAll(message);
					}
					await bannerRepository.NotifiedBannersAsync(bannerIds);
				}
			}
			catch (Exception ex)
			{
				throw new Exception(ex.Message);
			}
		}
	}
}