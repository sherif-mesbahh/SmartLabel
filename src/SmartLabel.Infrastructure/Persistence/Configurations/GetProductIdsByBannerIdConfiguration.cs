using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations
{
	public class GetProductIdsByBannerIdConfiguration : IEntityTypeConfiguration<GetProductIdsByBannerId>
	{
		public void Configure(EntityTypeBuilder<GetProductIdsByBannerId> builder)
		{
			builder.HasNoKey();
		}
	}
}
