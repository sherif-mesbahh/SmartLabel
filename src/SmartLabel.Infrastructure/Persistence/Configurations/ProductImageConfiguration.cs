using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations
{
	public class ProductImageConfiguration : IEntityTypeConfiguration<ProductImage>
	{
		public void Configure(EntityTypeBuilder<ProductImage> builder)
		{
			builder.HasKey(x => x.Id);
			builder.HasOne(x => x.Product)
				.WithMany(x => x.Images)
				.HasForeignKey(x => x.ProductId);
			builder.Property(x => x.ImageUrl).HasMaxLength(200);
		}
	}
}
