using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Results;

namespace SmartLabel.Application.Features.Categories.Command.Models
{
	public class AddCategoryCommand : IRequest<Response<AddCategoryCommand>>
	{
		public int Id { get; set; }
		public string Name { get; set; }
		public string? ImageUrl { get; set; }
		public AddCategoryCommand(AddCategoryResult category, string imageUrl)
		{
			Id = category.Id;
			Name = category.Name;
			ImageUrl = imageUrl;
		}
	}
}
