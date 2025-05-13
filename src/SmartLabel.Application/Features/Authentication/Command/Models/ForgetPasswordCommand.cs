using MediatR;
using SmartLabel.Application.Bases;

namespace SmartLabel.Application.Features.Authentication.Command.Models;
public class ForgetPasswordCommand : IRequest<Response<string>>
{
	public string Email { get; set; }
}