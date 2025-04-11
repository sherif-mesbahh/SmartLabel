using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Categories.Query.Results;

namespace SmartLabel.Application.Features.Categories.Query.Models;
public record GetAllCategoriesPaginatedQuery
(
	string? Search,
	string? SortColumn,
	string? SortOrder,
	int Page,
	int PageSize) : IRequest<PagedList<GetAllCategoriesDto>>;