using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.Products.Query.Models;
public record GetAllProductsPaginatedQuery
(
	string? Search,
	string? SortColumn,
	string? SortOrder,
	int Page,
	int PageSize) : IRequest<PagedList<GetAllProductsDto>>;