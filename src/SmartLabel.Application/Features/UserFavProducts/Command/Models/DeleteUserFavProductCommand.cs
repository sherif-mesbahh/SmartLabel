using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Models;
public class DeleteUserFavProductCommand(int productId) : IRequest<Response<string>>
{
	public int ProductId = productId;
}
