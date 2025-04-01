using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class BannerController(IMediator mediator) : AppControllerBase
{
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpGet]
	public async Task<IActionResult> GetAllBanners()
	{
		return NewResult(await mediator.Send(new GetAllBannersQuery()));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet("active")]
	public async Task<IActionResult> GetActiveBanners()
	{
		return NewResult(await mediator.Send(new GetActiveBannersQuery()));
	}
	[Authorize(Policy = nameof(Roles.UserOrAdmin))]
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetBannerById(int id)
	{
		return NewResult(await mediator.Send(new GetBannerByIdQuery(id)));
	}

	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpPost]
	public async Task<IActionResult> AddBanner([FromForm] AddBannerCommand banner)
	{
		return NewResult(await mediator.Send(banner));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpPut]
	public async Task<IActionResult> UpdateBanner([FromForm] UpdateBannerCommand banner)
	{
		return NewResult(await mediator.Send(banner));
	}
	[Authorize(Roles = nameof(Roles.Admin))]
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteBanner(int id)
	{
		return NewResult(await mediator.Send(new DeleteBannerCommand(id)));
	}
}