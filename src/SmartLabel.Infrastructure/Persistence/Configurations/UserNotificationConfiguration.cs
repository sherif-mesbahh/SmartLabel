using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations;
public class UserNotificationConfiguration : IEntityTypeConfiguration<UserNotification>
{
	public void Configure(EntityTypeBuilder<UserNotification> builder)
	{
		builder.HasKey(x => x.Id);
		builder.HasOne(x => x.Notification)
			.WithMany(x => x.UserNotifications)
			.HasForeignKey(x => x.NotificationId);

		builder.HasOne(x => x.User)
			.WithMany(x => x.UserNotifications)
			.HasForeignKey(x => x.UserId);
	}
}