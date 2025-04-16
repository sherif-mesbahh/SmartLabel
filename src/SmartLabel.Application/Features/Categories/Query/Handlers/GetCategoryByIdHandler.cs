using MediatR;
using Microsoft.AspNetCore.Http;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Models;
using SmartLabel.Application.Features.Categories.Query.Results;
using SmartLabel.Application.Repositories;
using SmartLabel.Domain.Helpers;
using System.Security.Claims;

namespace SmartLabel.Application.Features.Categories.Query.Handlers;
public class GetCategoryByIdHandler(ICategoryRepository categoryRepository, IHttpContextAccessor httpContextAccessor) : ResponseHandler,
	IRequestHandler<GetCategoryByIdQuery, Response<GetCategoryByIdDto>>
{
	public async Task<Response<GetCategoryByIdDto>> Handle(GetCategoryByIdQuery request, CancellationToken cancellationToken)
	{
		var userId = httpContextAccessor.HttpContext?.User?.FindFirstValue(nameof(UserClaimModel.UserId));
		var category = await categoryRepository.GetCategoryByIdAsync(request.Id, userId);
		if (category is null)
			return NotFound<GetCategoryByIdDto>([$"Category ID: {request.Id} not found"], "Category discontinued");
		return Success(category, $"Category {request.Id} retrieved successfully");
	}
}