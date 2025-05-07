using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Entities.Identity;

namespace SmartLabel.Infrastructure.Persistence.Data;
public class AppDbContext
	: IdentityDbContext<ApplicationUser, Role, int, IdentityUserClaim<int>, IdentityUserRole<int>, IdentityUserLogin<int>, IdentityRoleClaim<int>, IdentityUserToken<int>>
{
	public AppDbContext()
	{

	}
	public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
	{

	}
	public DbSet<UserToken> UserTokens { get; set; }
	public DbSet<Product> Products { get; set; }
	public DbSet<Category> Categories { get; set; }
	public DbSet<ProductImage> ProductImages { get; set; }
	public DbSet<BannerImage> BannerImages { get; set; }
	public DbSet<Banner> Banners { get; set; }
	public DbSet<UserFavProduct> UserFavProducts { get; set; }
	public DbSet<Role> Roles { get; set; }
	public DbSet<Notification> Notifications { get; set; }
	protected override void OnModelCreating(ModelBuilder modelBuilder)
	{
		base.OnModelCreating(modelBuilder);
		modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
	}
}