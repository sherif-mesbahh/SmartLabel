using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.UserFavProducts.Command.Models;
public class AddUserFavProductCommand : IRequest<Response<string>>
{
	public int UserId { get; set; }
	public int ProductId { get; set; }
}