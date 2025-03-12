using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Command.Results;

namespace SmartLabel.Application.Features.Products.Command.Models
{
	public class UpdateProductCommand : IRequest<Response<string>>
	{
		public int Id { get; set; }
		public string Name { get; set; }
		public decimal OldPrice { get; set; }
		public decimal NewPrice { get; set; }
		public int Discount { get; set; }
		public string? Description { get; set; }
		public int CatId { get; set; }
		public UpdateProductCommand(UpdateProductResult product)
		{
			Id = product.Id;
			Name = product.Name;
			OldPrice = product.OldPrice;
			Discount = product.Discount;
			NewPrice = (OldPrice - (((decimal)Discount / 100) * OldPrice));
			Description = product.Description;
			CatId = product.CatId;
		}
	}
}
