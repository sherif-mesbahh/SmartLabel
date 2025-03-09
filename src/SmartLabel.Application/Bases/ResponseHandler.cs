namespace SmartLabel.Application.Bases;
public class ResponseHandler
{
	public ResponseHandler()
	{

	}
	public Response<T> Success<T>(T entity, string? message = null)
	{
		return new Response<T>()
		{
			Data = entity,
			StatusCode = System.Net.HttpStatusCode.OK,
			Succeeded = true,
			Message = message ?? "Getting Successfully",
		};
	}
	public Response<T> Updated<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = System.Net.HttpStatusCode.OK,
			Succeeded = true,
			Message = message ?? "Updated Successfully",
		};
	}
	public Response<T> Deleted<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = System.Net.HttpStatusCode.OK,
			Succeeded = true,
			Message = message ?? "Deleted Successfully",
		};
	}
	public Response<T> Unauthorized<T>()
	{
		return new Response<T>()
		{
			StatusCode = System.Net.HttpStatusCode.Unauthorized,
			Succeeded = true,
			Message = "UnAuthorized"
		};
	}
	public Response<T> BadRequest<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = System.Net.HttpStatusCode.BadRequest,
			Succeeded = false,
			Message = message ?? "Bad Request"
		};
	}
	public Response<T> UnprocessableEntity<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = System.Net.HttpStatusCode.UnprocessableEntity,
			Succeeded = false,
			Message = message ?? "UnprocessableEntity"
		};
	}

	public Response<T> NotFound<T>(string? message = null)
	{
		return new Response<T>()
		{
			StatusCode = System.Net.HttpStatusCode.NotFound,
			Succeeded = false,
			Message = message ?? "Not Found"
		};
	}

	public Response<T> Created<T>(T entity, string? message = null)
	{
		return new Response<T>()
		{
			Data = entity,
			StatusCode = System.Net.HttpStatusCode.Created,
			Succeeded = true,
			Message = message ?? "Created"
		};
	}
}
