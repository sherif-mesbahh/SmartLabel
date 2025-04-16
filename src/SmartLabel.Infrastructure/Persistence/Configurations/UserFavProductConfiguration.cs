using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations;
public class UserFavProductConfiguration : IEntityTypeConfiguration<UserFavProduct>
{
	public void Configure(EntityTypeBuilder<UserFavProduct> builder)
	{
		builder.HasKey(x => x.Id);
		builder.HasOne(x => x.User)
			.WithMany(x => x.UsserFavProducts)
			.HasForeignKey(x => x.UserId);
		builder.HasOne(x => x.Product)
			.WithMany(x => x.UserFavProducts)
			.HasForeignKey(x => x.ProductId);
	}
}
