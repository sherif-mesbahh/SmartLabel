using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartLabel.Application.Features.Categories.Command.Results
{
	public class UpdateCategoryResult
	{
		public int Id { get; set; }
		public string Name { get; set; } = null!;
		public IFormFile? Image { get; set; }
	}
}
