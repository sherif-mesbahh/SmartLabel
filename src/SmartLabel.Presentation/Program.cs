using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.Extensions.FileProviders;
using Microsoft.OpenApi.Models;
using SmartLabel.Application;
using SmartLabel.Application.Enumeration;
using SmartLabel.Infrastructure;
using SmartLabel.Infrastructure.Hubs;
using SmartLabel.Infrastructure.Services;
using SmartLabel.Presentation.Middlewares;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddHostedService<BannerActivationService>();
builder.Services.AddSwaggerGen();
builder.Services.AddTransient<ErrorHandlerMiddleware>();
builder.Services
	.AddInfrastructures(builder.Configuration)
	.AddApplications();

builder.Services.AddMemoryCache();

builder.Services.AddRateLimiter(RateLimiterOptions =>
{
	RateLimiterOptions.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
	RateLimiterOptions.AddTokenBucketLimiter("Token", opt =>
	{
		opt.TokenLimit = 60;
		opt.ReplenishmentPeriod = TimeSpan.FromSeconds(1);
		opt.TokensPerPeriod = 30;
	});
});

builder.Services.Configure<ApiBehaviorOptions>(options =>
{
	options.SuppressModelStateInvalidFilter = true; // Disable the default validation behavior
});

builder.Services.AddSwaggerGen(c =>
{
	c.SwaggerDoc("v1",
		new OpenApiInfo
		{
			Title = "Smart Label API",
			Version = "v1",
			Contact = new OpenApiContact
			{
				Name = ": Support Team",
				Email = "sherifmesbah4@gmail.com"
			}
		});

	c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
	{
		Description = "JWT Authorization header using the Bearer scheme.",
		Name = "Authorization",
		In = ParameterLocation.Header,
		Type = SecuritySchemeType.Http,
		Scheme = "Bearer"
	});

	c.AddSecurityRequirement(new OpenApiSecurityRequirement
	{
		{
			new OpenApiSecurityScheme
			{
				Reference = new OpenApiReference
				{
					Type = ReferenceType.SecurityScheme,
					Id = "Bearer"
				}
			},
			Array.Empty<string>()
		}
	});
});


builder.Services.AddSignalR();
builder.Services.AddAuthorizationBuilder()
	.AddPolicy(nameof(RolesEnum.UserOrAdmin), policy =>
		policy.RequireRole(RolesEnum.User.ToString(), RolesEnum.Admin.ToString()));

var app = builder.Build();

app.UseCors(x => x
	.WithOrigins("http://localhost:5173", "http://localhost:5174", "https://smartlabell.netlify.app")
	.AllowAnyMethod()
	.AllowAnyHeader());

app.UseSwagger();
app.UseSwaggerUI();


app.UseStaticFiles(new StaticFileOptions
{
	FileProvider = new PhysicalFileProvider(
		Path.Combine(builder.Environment.WebRootPath, "Uploads")),
	RequestPath = "/Uploads"
});

app.UseMiddleware<ErrorHandlerMiddleware>();
app.UseHttpsRedirection();
app.UseRouting();
app.UseRateLimiter();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers().RequireRateLimiting("Token");
app.MapHub<NotificationHub>("/Notify");
app.Run();