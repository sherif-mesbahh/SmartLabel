using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Infrastructure.Interfaces;
using SmartLabel.Infrastructure.Persistence.Data;
using SmartLabel.Infrastructure.Persistence.Repositories;
using SmartLabel.Infrastructure.Persistence.Repositories.StoredProceduresRepositories;
using SmartLabel.Infrastructure.Services;
using System.Text;

namespace SmartLabel.Infrastructure;
public static class InfrastructureModuleDependencies
{
	public static IServiceCollection AddInfrastructures(this IServiceCollection services, IConfiguration configuration)
	{
		services.AddDbContext<AppDbContext>(options => options.UseSqlServer(configuration.GetConnectionString("SqlConnection")));
		services.AddTransient<ICategoryRepository, CategoryRepository>();
		services.AddTransient<IProductRepository, ProductRepository>();
		services.AddTransient<IBannerRepository, BannerRepository>();
		services.AddTransient<ICategoryProcRepository, CategoryProcRepository>();
		services.AddTransient<IProductProcRepository, ProductProcRepository>();
		services.AddTransient<IBannerProcRepository, BannerProcRepository>();
		services.AddTransient<IUserProductsProcRepository, UserProductsProcRepository>();
		services.AddTransient<IFileService, FileService>();
		services.AddTransient<IUnitOfWork, UnitOfWork>();
		services.AddTransient<IAuthenticationRepository, AuthenticationRepository>();
		services.AddTransient<IAuthorizationRepository, AuthorizationRepository>();
		services.AddTransient<IUsersRepository, UsersRepository>();
		services.AddTransient<IUserFavProductRepository, UserFavProductRepository>();
		services.AddTransient<ISqlConnectionFactory, SqlConnectionFactory>();
		services.AddTransient<IEmailService, EmailService>();
		services.AddTransient<INotifierService, NotifierService>();
		services.AddTransient<INotificationRepository, NotificationRepository>();
		services.AddIdentity<ApplicationUser, Role>(
				options =>
				{
					// Lockout settings.
					options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
					options.Lockout.MaxFailedAccessAttempts = 5;
					options.Lockout.AllowedForNewUsers = true;
					options.SignIn.RequireConfirmedAccount = true;
					options.User.RequireUniqueEmail = true;
				}
			).AddEntityFrameworkStores<AppDbContext>()
			.AddDefaultTokenProviders();
		var jwtSettings = new JwtSettings();
		configuration.GetSection(nameof(JwtSettings)).Bind(jwtSettings);
		services.AddSingleton(jwtSettings);
		var emailSettings = new EmailSettings();
		configuration.GetSection(nameof(EmailSettings)).Bind(emailSettings);
		services.AddSingleton(emailSettings);

		services.AddAuthentication(
				x =>
				{

					x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
					x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
				})
			.AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
				{
					options.SaveToken = true;
					options.TokenValidationParameters = new TokenValidationParameters()
					{
						ValidateLifetime = jwtSettings.ValidateLifetime,
						ValidateIssuer = jwtSettings.ValidateIssuer,
						ValidIssuer = jwtSettings.Issuer,
						ValidateAudience = jwtSettings.ValidateAudience,
						ValidAudience = jwtSettings.Audience,
						ValidateIssuerSigningKey = jwtSettings.ValidateSigningKey,
						IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SigningKey))
					};
					options.Events = new JwtBearerEvents
					{
						OnMessageReceived = context =>
						{
							var accessToken = context.Request.Query["access_token"];
							var path = context.HttpContext.Request.Path;
							if (!string.IsNullOrEmpty(accessToken) &&
								path.StartsWithSegments("/notificationHub"))
							{
								context.Token = accessToken;
							}
							return Task.CompletedTask;
						}
					};
				});

		return services;
	}
}