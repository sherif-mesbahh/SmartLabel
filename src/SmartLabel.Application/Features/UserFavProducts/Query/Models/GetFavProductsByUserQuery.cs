using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Domain.SharedResults;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Models;
public class GetFavProductsByUserQuery(int userId) : IRequest<Response<IEnumerable<UserFavProductResult>>>
{
	public int UserId = userId;
}