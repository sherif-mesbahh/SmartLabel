using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Products.Command.Models;
public class AddProductCommand : IRequest<Response<string>>
{
	public int Id { get; set; }
	public string Name { get; set; } = null!;
	public decimal OldPrice { get; set; }
	public int Discount { get; set; }
	public string? Description { get; set; }
	public int CatId { get; set; }
	public List<IFormFile>? ImagesFiles { get; set; }
}
