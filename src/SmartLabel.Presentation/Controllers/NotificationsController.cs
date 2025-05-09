using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Notifications.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	[Authorize]
	public class NotificationsController(ISender sender) : AppControllerBase
	{
		[HttpGet("/me")]
		public async Task<IActionResult> GetNotifications()
		{
			return NewResult(await sender.Send(new GetNotificationsCommand()));
		}

	}
}
