using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Banners.Command.Models;
public class DeleteBannerCommand(int id) : IRequest<Response<string>>
{
	public int Id = id;
}