using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Enumeration;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Application.Features.Banners.Query.Results;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class BannersController(ISender sender) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllBanners()
	{
		return NewResult(await sender.Send(new GetAllBannersQuery()));
	}
	[HttpGet("paginated")]
	public async Task<PagedList<GetBannersDto>> GetAllBannersPaginated([FromQuery] GetAllBannersPaginatedQuery query)
	{
		return await sender.Send(query);
	}
	[HttpGet("active")]
	public async Task<IActionResult> GetActiveBanners()
	{
		return NewResult(await sender.Send(new GetActiveBannersQuery()));
	}
	[HttpGet("active/paginated")]
	public async Task<PagedList<GetBannersDto>> GetActiveBannersPaginated([FromQuery] GetActiveBannersPaginatedQuery query)
	{
		return await sender.Send(query);
	}
	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetBannerById(int id)
	{
		return NewResult(await sender.Send(new GetBannerByIdQuery(id)));
	}

	[Authorize(Roles = nameof(RolesEnum.Admin))]
	[HttpPost]
	public async Task<IActionResult> AddBanner([FromForm] AddBannerCommand banner)
	{
		return NewResult(await sender.Send(banner));
	}
	[Authorize(Roles = nameof(RolesEnum.Admin))]
	[HttpPut]
	public async Task<IActionResult> UpdateBanner([FromForm] UpdateBannerCommand banner)
	{
		return NewResult(await sender.Send(banner));
	}
	[Authorize(Roles = nameof(RolesEnum.Admin))]
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteBanner(int id)
	{
		return NewResult(await sender.Send(new DeleteBannerCommand(id)));
	}
}