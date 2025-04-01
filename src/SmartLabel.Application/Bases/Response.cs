using System.Net;

namespace SmartLabel.Application.Bases;
public class Response<T>
{
	public HttpStatusCode StatusCode { get; set; }
	public bool Success { get; set; }
	public string? Message { get; set; }
	public List<string>? Errors { get; set; }
	public T? Data { get; set; }
}

