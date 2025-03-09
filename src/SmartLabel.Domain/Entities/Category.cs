using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartLabel.Domain.Entities
{
	public class Category
	{
		public int Id { get; set; }
		public string Name { get; set; } = null!;
		[NotMapped]
		public IFormFile? Image { get; set; }
		public string? ImageUrl { get; set; }
		public List<Product>? Products { get; set; } = new();
	}
}
