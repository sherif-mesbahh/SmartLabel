using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Infrastructure.Persistence.Configurations;
public class UserTokenConfiguration : IEntityTypeConfiguration<UserToken>
{
	public void Configure(EntityTypeBuilder<UserToken> builder)
	{
		builder.HasKey(x => x.Id);
		builder.Property(x => x.RefreshToken).HasMaxLength(200);
		builder.HasOne(x => x.User)
			.WithMany(x => x.Tokens)
			.HasForeignKey(x => x.UserId);
	}
}