using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class EmailConfirmCommand : IRequest<Response<string>>
{
	public int UserId { get; set; }
	public string Code { get; set; }
}