using System.Net;

namespace SmartLabel.Application.Bases;
public class ResponseHandler
{
	public ResponseHandler()
	{

	}
	public Response<T> Success<T>(T data, string? message = null)
	{
		return new Response<T>()
		{
			Data = data,
			StatusCode = HttpStatusCode.OK,
			Success = true,
			Message = message ?? "Operation completed"
		};
	}
	public Response<T> Created<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = HttpStatusCode.Created,
			Success = true,
			Message = message ?? "Created successfully"
		};
	}
	public Response<T> NoContent<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = HttpStatusCode.OK,
			Success = true,
			Message = message
		};
	}
	public Response<T> Unauthorized<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = HttpStatusCode.Unauthorized,
			Success = true,
			Message = message ?? "Invalid credentials",
		};
	}
	public Response<T> BadRequest<T>(List<string>? errors, string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = HttpStatusCode.BadRequest,
			Success = false,
			Message = message,
			Errors = errors ?? new List<string>()
		};
	}
	public Response<T> UnprocessableEntity<T>(List<string>? errors, string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = HttpStatusCode.UnprocessableEntity,
			Success = false,
			Message = message,
			Errors = errors ?? new List<string>()
		};
	}

	public Response<T> NotFound<T>(List<string>? errors, string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = HttpStatusCode.NotFound,
			Success = false,
			Message = message,
			Errors = errors ?? new List<string>()
		};
	}
	public Response<T> InternalServerError<T>(List<string>? errors, string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = HttpStatusCode.InternalServerError,
			Success = false,
			Message = message ?? "An error occurred",
			Errors = errors ?? new List<string>()
		};
	}
}
