using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Categories.Command.Models;
public class UpdateCategoryCommand : IRequest<Response<string>>
{
	public int Id { get; set; }
	public string Name { get; set; }
	public IFormFile? Image { get; set; }
}