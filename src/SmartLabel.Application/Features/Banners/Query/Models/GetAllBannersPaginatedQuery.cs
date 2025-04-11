using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Query.Results;

namespace SmartLabel.Application.Features.Banners.Query.Models;
public record GetAllBannersPaginatedQuery(
	string? Search,
	string? SortColumn,
	string? SortOrder,
	int Page,
	int PageSize) : IRequest<PagedList<GetBannersDto>>;