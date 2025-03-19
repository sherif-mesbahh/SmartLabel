using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations;
public class BannerImageConfiguration : IEntityTypeConfiguration<BannerImage>
{
	public void Configure(EntityTypeBuilder<BannerImage> builder)
	{
		builder.HasKey(x => x.Id);
		builder.HasOne(x => x.Banner)
			.WithMany(x => x.Images)
			.HasForeignKey(x => x.BannerId);
		builder.Property(x => x.ImageUrl).HasMaxLength(200);
	}
}