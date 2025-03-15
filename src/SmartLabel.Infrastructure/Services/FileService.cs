using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using SmartLabel.Domain.Services;

namespace SmartLabel.Infrastructure.Services
{
	public class FileService(IWebHostEnvironment host) : IFileService
	{
		public async Task<string> BuildImageAsync(IFormFile? image)
		{
			string uploadsFolder = Path.Combine(host.WebRootPath, "Uploads");
			if (!Directory.Exists(uploadsFolder))
			{
				Directory.CreateDirectory(uploadsFolder);
			}

			string uniqueFileName = Guid.NewGuid().ToString() + "_" + image?.FileName;
			string filePath = Path.Combine(uploadsFolder, uniqueFileName);
			using (var fileStream = new FileStream(filePath, FileMode.Create))
			{
				await image.CopyToAsync(fileStream);
			}

			// Return the file URL (relative to wwwroot)
			string fileUrl = uniqueFileName;
			return fileUrl;
		}

		public async Task DeleteImageAsync(string? imageUrl)
		{
			var contentPath = host.WebRootPath;
			var path = Path.Combine(contentPath, "Uploads", imageUrl);
			if (File.Exists(path))
			{
				await Task.Run(() => File.Delete(path));
			}
		}
	}
}
