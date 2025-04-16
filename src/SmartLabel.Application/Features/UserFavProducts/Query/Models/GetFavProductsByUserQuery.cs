using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Products.Query.Results;

namespace SmartLabel.Application.Features.UserFavProducts.Query.Models;
public class GetFavProductsByUserQuery : IRequest<Response<IEnumerable<GetAllProductsDto>>>
{
}