using MediatR;
using SmartLabel.Application.Bases;
using UserFavProductDto = SmartLabel.Application.Features.UserFavProducts.Query.Results.UserFavProductDto;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Models;
public class GetFavProductsByUserQuery : IRequest<Response<IEnumerable<UserFavProductDto>>>
{
}