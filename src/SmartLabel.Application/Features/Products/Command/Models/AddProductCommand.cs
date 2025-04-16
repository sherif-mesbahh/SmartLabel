using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Products.Command.Models;
public class AddProductCommand : IRequest<Response<string>>
{
	public string Name { get; set; } = string.Empty;
	public decimal OldPrice { get; set; }
	public int Discount { get; set; }
	public string? Description { get; set; }
	public int CatId { get; set; }
	public IFormFile? MainImage { get; set; }
	public List<IFormFile>? ImagesFiles { get; set; }
}
