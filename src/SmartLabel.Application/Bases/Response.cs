using System.Net;

namespace SmartLabel.Application.Bases;
public class Response<T>
{
	public HttpStatusCode StatusCode { get; set; }
	public bool Succeeded { get; set; }
	public string? Message { get; set; }
	public Dictionary<string, List<string>> Errors { get; set; } = new();
	public T? Data { get; set; }
}

