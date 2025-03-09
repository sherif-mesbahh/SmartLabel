using Microsoft.AspNetCore.Http;
using SmartLabel.Domain.Entities;
using System.ComponentModel.DataAnnotations.Schema;

namespace SmartLabel.Application.Features.Categories.Query.Results;
public class GetCategoryResultById
{
	public int Id { get; set; }
	public string Name { get; set; } = null!;
	public string? ImageUrl { get; set; }
	public List<Product>? Products { get; set; } = new();
}