using Microsoft.AspNetCore.Http;

namespace SmartLabel.Domain.Services
{
	public interface IFileService
	{
		public Task<string> BuildImageAsync(IFormFile image);
		public Task DeleteImageAsync(string? imageUrl);
	}
}
