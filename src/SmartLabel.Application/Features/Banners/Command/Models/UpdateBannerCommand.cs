using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Banners.Command.Models;
public class UpdateBannerCommand : IRequest<Response<string>>
{
	public int Id { get; set; }
	public string Title { get; set; }
	public string? Description { get; set; }
	public DateTime StartDate { get; set; }
	public DateTime EndDate { get; set; }
	public List<IFormFile>? ImagesFiles { get; set; }
	public List<int>? RemovedImageIds { get; set; }
}
