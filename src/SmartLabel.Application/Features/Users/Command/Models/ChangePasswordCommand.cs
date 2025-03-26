using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Users.Command.Models;
public class ChangePasswordCommand : IRequest<Response<string>>
{
	public string CurrentPassword { get; set; }
	public string NewPassword { get; set; }
	public string ConfirmPassword { get; set; }
}
