using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;
using SmartLabel.Infrastructure.Persistence.Repositories;

namespace SmartLabel.Infrastructure
{
	public static class InfrastructureModuleDependencies
	{
		public static IServiceCollection AddInfrastructures(this IServiceCollection services, IConfiguration configuration)
		{
			services.AddDbContext<AppDbContext>(options => options.UseSqlServer(configuration.GetConnectionString("SqlConnection")));
			services.AddTransient<ICategoryRepository, CategoryRepository>();
			services.AddTransient<IProductRepository, ProductRepository>();
			services.AddTransient<IProductImageRepository, ProductImageRepository>();
			services.AddTransient<IBannerRepository, BannerRepository>();
			services.AddTransient<IBannerProductRepository, BannerProductRepository>();
			services.AddTransient<IStoredProceduresRepository, StoredProceduresRepository>();
			return services;
		}
	}
}
