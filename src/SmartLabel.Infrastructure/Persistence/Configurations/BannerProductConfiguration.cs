using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations
{
	public class BannerProductConfiguration : IEntityTypeConfiguration<BannerProduct>
	{
		public void Configure(EntityTypeBuilder<BannerProduct> builder)
		{
			builder.HasKey(x => x.Id);
			builder.HasOne(x => x.Banner)
				.WithMany(x => x.BannerProducts)
				.HasForeignKey(x => x.BannerId)
				.OnDelete(deleteBehavior: DeleteBehavior.Cascade);

			builder.HasOne(x => x.Product)
				.WithMany(x => x.BannerProducts)
				.HasForeignKey(x => x.ProductId)
				.OnDelete(deleteBehavior: DeleteBehavior.Cascade);
		}
	}
}
