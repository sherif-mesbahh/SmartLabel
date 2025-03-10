using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations.Schema;

namespace SmartLabel.Domain.Entities
{
	public class Category
	{
		public int Id { get; set; }
		public string Name { get; set; } = null!;
		[NotMapped]
		public IFormFile? Image { get; set; }
		public string? ImageUrl { get; set; }
		public ICollection<Product>? Products { get; set; }
	}
}
