using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Domain.Shared.Results.UserFavProducts;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Models;
public class GetFavProductsByUserQuery(int userId) : IRequest<Response<IEnumerable<UserFavProductDto>>>
{
	public int UserId = userId;
}