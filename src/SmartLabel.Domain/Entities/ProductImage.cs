using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations.Schema;

namespace SmartLabel.Domain.Entities
{
	public class ProductImage
	{
		public int Id { get; set; }
		[NotMapped]
		public IFormFile? Image { get; set; }
		public string? ImageUrl { get; set; }
		public int ProductId { get; set; }
		public Product Product { get; set; }
	}
}
