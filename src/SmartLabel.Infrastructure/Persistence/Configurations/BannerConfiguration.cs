using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations;
public class BannerConfiguration : IEntityTypeConfiguration<Banner>
{
	public void Configure(EntityTypeBuilder<Banner> builder)
	{
		builder.HasKey(x => x.Id);
		builder.Property(x => x.Title).HasMaxLength(1000);
		builder.Property(x => x.Description).HasMaxLength(2000);
		builder.Property(x => x.MainImage).HasMaxLength(200);
	}
}