using MediatR;
namespace SmartLabel.Application.Features.ProductImages.Command.Models
{
	public class AddProductImageCommand : IRequest
	{
		public int Id { get; set; }
		public string? ImageUrl { get; set; }
		public int ProductId { get; set; }
		public AddProductImageCommand(Domain.Entities.ProductImage productImage)
		{
			Id = productImage.Id;
			ImageUrl = productImage.ImageUrl;
			ProductId = productImage.ProductId;
		}
	}
}
