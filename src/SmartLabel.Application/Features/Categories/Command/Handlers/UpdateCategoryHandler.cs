using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Command.Models;
using SmartLabel.Application.Repositories;
using SmartLabel.Application.Services;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class UpdateCategoryHandler(ICategoryRepository categoryRepository, IMapper mapper, IFileService fileService,
	IMemoryCache memoryCache, IHttpContextAccessor httpContextAccessor)
	: ResponseHandler, IRequestHandler<UpdateCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(UpdateCategoryCommand request,
		CancellationToken cancellationToken)
	{
		if (!await categoryRepository.IsCategoryExistAsync(request.Id, cancellationToken))
			return NotFound<string>([$"Category ID: {request.Id} not found"], "Category discontinued");

		try
		{
			var category = mapper.Map<Category>(request);
			var imageUrl = await categoryRepository.GetCategoryImageByIdAsync(category.Id);
			if (request.Image is not null && imageUrl is not null) await fileService.DeleteImageAsync(imageUrl);
			if (request.Image is not null) category.ImageUrl = await fileService.BuildImageAsync(request.Image);
			await categoryRepository.UpdateCategoryAsync(category.Id, category, imageUrl);
			var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
			InvalidCache(category.Id, userId);
			return NoContent<string>();
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Updating category temporarily unavailable");
		}
	}
	private void InvalidCache(int categoryId, string? userId)
	{
		memoryCache.Remove($"Categories");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-{userId}");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-");
	}
}
