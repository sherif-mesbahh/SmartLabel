using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Banners.Command.Models;
public class AddBannerCommand : IRequest<Response<string>>
{
	public required string Title { get; set; }
	public string? Description { get; set; }
	public DateTime StartDate { get; set; }
	public DateTime EndDate { get; set; }
	public List<IFormFile>? ImagesFiles { get; set; }
}
