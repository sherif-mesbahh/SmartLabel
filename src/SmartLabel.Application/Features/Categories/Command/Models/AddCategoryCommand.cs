using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Categories.Command.Models;
public class AddCategoryCommand : IRequest<Response<string>>
{
	public string Name { get; set; } = string.Empty;
	public IFormFile? Image { get; set; }
}