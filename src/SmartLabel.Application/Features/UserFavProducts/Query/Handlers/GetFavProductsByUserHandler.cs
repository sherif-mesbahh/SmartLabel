using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Shared.Results.UserFavProducts;
namespace SmartLabel.Application.Features.UserFavProducts.Query.Handlers;
public class GetFavProductsByUserHandler(IUserFavProductRepository userFavProductRepository) : ResponseHandler, IRequestHandler<GetFavProductsByUserQuery, Response<IEnumerable<UserFavProductDto>>>
{
	public async Task<Response<IEnumerable<UserFavProductDto>>> Handle(GetFavProductsByUserQuery request, CancellationToken cancellationToken)
	{
		var favoriteProducts = await userFavProductRepository.GetFavProductsByUserAsync(request.UserId);
		return Success(favoriteProducts, "All Products getting successfully");
	}
}
