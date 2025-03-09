using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
