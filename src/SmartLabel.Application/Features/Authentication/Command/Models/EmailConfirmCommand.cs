using MediatR;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class EmailConfirmCommand : IRequest<bool>
{
	public int UserId { get; set; }
	public string Code { get; set; }
}