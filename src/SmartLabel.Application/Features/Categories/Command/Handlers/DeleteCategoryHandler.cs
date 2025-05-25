using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class DeleteCategoryHandler(ICategoryRepository categoryRepository, IFileService fileService,
	IMemoryCache memoryCache, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<DeleteCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
	{
		if (!await categoryRepository.IsCategoryExistAsync(request.Id, cancellationToken))
			return NotFound<string>([$"Category ID: {request.Id} not found"], "Category discontinued");

		try
		{
			var categoryImage = await categoryRepository.GetCategoryImageByIdAsync(request.Id);
			if (categoryImage is not null) await fileService.DeleteImageAsync(categoryImage);
			await categoryRepository.DeleteCategoryAsync(request.Id);
			var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
			InvalidCache(request.Id, userId);
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Deleting category temporarily unavailable");
		}
	}
	private void InvalidCache(int categoryId, string? userId)
	{
		memoryCache.Remove($"Categories");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-{userId}");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-");
		//memoryCache.Remove($"Products");
		memoryCache.Remove($"Products-{userId}");
		memoryCache.Remove($"Products-");
		memoryCache.Remove($"ProductsFav-{userId}");
	}
}