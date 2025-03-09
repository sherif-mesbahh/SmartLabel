using FluentValidation;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using SmartLabel.Application.Behaviors;
using System.Reflection;

namespace SmartLabel.Application;
public static class ApplicationModuleDependencies
{
	public static IServiceCollection AddApplications(this IServiceCollection services)
	{
		services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblies(Assembly.GetExecutingAssembly()));
		services.AddAutoMapper(Assembly.GetExecutingAssembly());
		services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());
		services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));
		return services;
	}
}