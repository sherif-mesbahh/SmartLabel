using FluentValidation;
using Microsoft.IdentityModel.Tokens;
using SmartLabel.Application.Bases;
using System.Net;

namespace SmartLabel.Presentation.Middlewares;
public class ErrorHandlerMiddleware : IMiddleware
{
	public async Task InvokeAsync(HttpContext context, RequestDelegate next)
	{
		try
		{
			await next(context);
		}
		catch (Exception ex)
		{
			var response = context.Response;
			response.StatusCode = StatusCodes.Status400BadRequest;
			context.Response.ContentType = "application/json";
			var responseModel = new Response<string>() { Succeeded = false };
			switch (ex)
			{
				case ValidationException e:
					responseModel.Message = "Validation Error";
					responseModel.StatusCode = HttpStatusCode.UnprocessableEntity;
					response.StatusCode = (int)HttpStatusCode.UnprocessableEntity;
					responseModel.Errors = e.Errors
						.GroupBy(x => x.PropertyName)
						.ToDictionary(
							g => g.Key,
							g => g.Select(x => x.ErrorMessage).ToList()
						);
					break;
				case KeyNotFoundException e:
					responseModel.Message = e.Message;
					responseModel.StatusCode = HttpStatusCode.NotFound;
					response.StatusCode = (int)HttpStatusCode.NotFound;
					break;
				case SecurityTokenException e:
					responseModel.Message = e.Message;
					responseModel.StatusCode = HttpStatusCode.Unauthorized;
					response.StatusCode = (int)HttpStatusCode.Unauthorized;
					break;
				case { } e:
					responseModel.Message = e.Message;
					responseModel.StatusCode = HttpStatusCode.BadRequest;
					response.StatusCode = (int)HttpStatusCode.BadRequest;
					break;
			}
			await response.WriteAsJsonAsync(responseModel);
		}
	}
}

