using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.SharedResults;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Handlers;
public class GetFavProductsByUserHandler(IUserFavProductRepository userFavProductRepository) : ResponseHandler, IRequestHandler<GetFavProductsByUserQuery, Response<IEnumerable<UserFavProductResult>>>
{
	public async Task<Response<IEnumerable<UserFavProductResult>>> Handle(GetFavProductsByUserQuery request, CancellationToken cancellationToken)
	{
		var favoriteProducts = await userFavProductRepository.GetFavProductsByUser(request.UserId);
		return Success(favoriteProducts, "All Products getting successfully");
	}
}
