using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Models;
public record GetFavProductsPaginatedByUserQuery
(
	string? Search,
	string? SortColumn,
	string? SortOrder,
	int Page,
	int PageSize) : IRequest<PagedList<GetAllProductsDto>>;
