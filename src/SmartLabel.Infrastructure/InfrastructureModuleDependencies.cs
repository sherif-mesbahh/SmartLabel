﻿using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Repositories.StoredProceduresRepositories;
using SmartLabel.Domain.Entities.Identity;
using SmartLabel.Domain.Helpers;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Services;
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
		services.AddIdentity<ApplicationUser, Role>(
				options =>
				{
					options.Password.RequireDigit = true;
					options.Password.RequireLowercase = true;
					options.Password.RequireNonAlphanumeric = true;
					options.Password.RequireUppercase = true;
					options.Password.RequiredLength = 6;
					options.Password.RequiredUniqueChars = 1;

					// Lockout settings.
					options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
					options.Lockout.MaxFailedAccessAttempts = 5;
					options.Lockout.AllowedForNewUsers = true;
					options.User.RequireUniqueEmail = true;
				}
			).AddEntityFrameworkStores<AppDbContext>()
			.AddDefaultTokenProviders();
		var jwtSettings = new JwtSettings();
		configuration.GetSection(nameof(JwtSettings)).Bind(jwtSettings);
		services.AddSingleton(jwtSettings);

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
				}
				);
		return services;
	}
}