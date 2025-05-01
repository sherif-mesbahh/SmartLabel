using Microsoft.AspNetCore.Http;

namespace SmartLabel.Application.Services;
public interface IFileService
{
	public Task<string> BuildImageAsync(IFormFile image);
	public Task DeleteImageAsync(string? imageUrl);
}