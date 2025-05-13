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
using SmartLabel.Domain.Interfaces;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Categories.Command.Handlers;
public class AddCategoryHandler(IMapper mapper, ICategoryRepository categoryRepository, IMemoryCache memoryCache,
	IHttpContextAccessor httpContextAccessor, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler,
	IRequestHandler<AddCategoryCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddCategoryCommand request, CancellationToken cancellationToken)
	{
		try
		{
			var category = mapper.Map<Category>(request);
			if (request.Image is not null)
				category.ImageUrl = await fileService.BuildImageAsync(request.Image);
			await categoryRepository.AddCategoryAsync(category);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
			NewMethod(category.Id, userId);
			return Created<string>($"Category {category.Id} created successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>([ex.Message], "Adding category temporarily unavailable");
		}
	}

	private void NewMethod(int categoryId, string? userId)
	{
		memoryCache.Remove($"Categories");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-{userId}");
		memoryCache.Remove($"CategoryId-{categoryId}UserId-");
	}
}