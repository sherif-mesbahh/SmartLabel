﻿using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.Notifications.Command.Models;
using SmartLabel.Application.Features.Notifications.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	[Authorize]
	public class NotificationsController(ISender sender) : AppControllerBase
	{
		[HttpGet("me")]
		public async Task<IActionResult> GetNotifications()
		{
			return NewResult(await sender.Send(new GetNotificationsQuery()));
		}
		[HttpGet("{id}")]
		public async Task<IActionResult> GetNotificationById(int id)
		{
			return NewResult(await sender.Send(new GetNotificationByIdQuery(id)));
		}
		[HttpPut("{id}")]
		public async Task<IActionResult> MakeNotificationRead(int id)
		{
			return NewResult(await sender.Send(new MakeNotificationReadCommand(id)));
		}

	}
}
