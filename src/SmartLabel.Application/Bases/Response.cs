using System.Net;

namespace SmartLabel.Application.Bases;
public class Response<T>
{
	public Response()
	{

	}
	public Response(T data, string? message = null)
	{
		Succeeded = true;
		Message = message;
		Data = data;
	}
	public Response(string? message)
	{
		Succeeded = false;
		Message = message;
	}
	public Response(string? message, bool succeeded)
	{
		Succeeded = succeeded;
		Message = message;
	}

	public HttpStatusCode StatusCode { get; set; }
	public bool Succeeded { get; set; }
	public string? Message { get; set; }
	public Dictionary<string, List<string>> Errors { get; set; } = new();
	public T Data { get; set; }
}

