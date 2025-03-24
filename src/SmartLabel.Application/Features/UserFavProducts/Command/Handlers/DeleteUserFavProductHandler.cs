using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Handlers;
public class DeleteUserFavProductHandler(IUserFavProductRepository userFavProductRepository) : ResponseHandler, IRequestHandler<DeleteUserFavProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteUserFavProductCommand request, CancellationToken cancellationToken)
	{
		var userFavProduct = await userFavProductRepository.GetUserFavProduct(request.UserId, request.ProductId);
		if (userFavProduct is null)
			return NotFound<string>("This productId or userId is not found");

		await userFavProductRepository.DeleteFavProduct(userFavProduct);
		return Deleted<string>("Like is Deleted successfully");
	}
}