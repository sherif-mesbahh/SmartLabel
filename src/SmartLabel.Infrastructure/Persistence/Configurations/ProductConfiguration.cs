using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Configurations
{
	public class ProductConfiguration : IEntityTypeConfiguration<Product>
	{
		public void Configure(EntityTypeBuilder<Product> builder)
		{
			builder.HasKey(x => x.Id);
			builder.Property(x => x.Name).HasMaxLength(200);
			builder.Property(x => x.Description).HasMaxLength(400);
			builder.Property(x => x.OldPrice).HasPrecision(18, 2);
			builder.Property(x => x.NewPrice).HasPrecision(18, 2);
			builder.Property(x => x.Discount).HasColumnType("INT");
			builder.HasOne(x => x.Category)
				.WithMany(x => x.Products)
				.HasForeignKey(x => x.CatId);

		}
	}
}
