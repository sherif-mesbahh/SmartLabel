using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;

namespace SmartLabel.Infrastructure.Persistence.Data
{
	public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
	{
		public DbSet<Product> Products { get; set; }
		public DbSet<Category> Categories { get; set; }
		public DbSet<ProductImage> ProductImages { get; set; }
		public DbSet<Banner> Banners { get; set; }
		public DbSet<BannerProduct> BannerProducts { get; set; }
		public DbSet<GetProductIdsByBannerId> ProductIds { get; set; }
		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			base.OnModelCreating(modelBuilder);
			modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
		}
	}
}
