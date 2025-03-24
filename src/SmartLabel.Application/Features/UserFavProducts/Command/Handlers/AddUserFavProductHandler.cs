using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.UserFavProducts.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Handlers;
public class AddUserFavProductHandler(IUserFavProductRepository userFavProductRepository, IProductRepository productRepository) : ResponseHandler, IRequestHandler<AddUserFavProductCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddUserFavProductCommand request, CancellationToken cancellationToken)
	{
		if (!await productRepository.IsProductExist(request.ProductId))
			return NotFound<string>("This productId or userId is not found");
		var userFavProduct = new UserFavProduct()
		{
			Id = 0,
			UserId = request.UserId,
			ProductId = request.ProductId
		};
		await userFavProductRepository.AddFavProduct(userFavProduct);
		return Created<string>("Like is added successfully");
	}
}
