namespace SmartLabel.Presentation.Services
{
	public interface IFileService
	{
		public Task<string> BuildImage(IFormFile image);
		public void DeleteImage(string? imageUrl);
	}
}
