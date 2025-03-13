using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.BannerProducts.Command.Models;
using SmartLabel.Application.Features.BannerProducts.Command.Results;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Features.Banners.Command.Results;
using SmartLabel.Application.Features.Banners.Query.Models;
using SmartLabel.Domain.Repositories;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class BannerController(IMediator mediator, IStoredProceduresRepository repository) : AppControllerBase
{
	[HttpGet]
	public async Task<IActionResult> GetAllBanners()
	{
		return NewResult(await mediator.Send(new GetAllBannersQuery()));
	}

	[HttpGet("Active")]
	public async Task<IActionResult> GetActiveBanners()
	{
		return NewResult(await mediator.Send(new GetActiveBannersQuery()));
	}

	[HttpGet("{id:int}")]
	public async Task<IActionResult> GetBannerById(int id)
	{
		return NewResult(await mediator.Send(new GetBannerByIdQuery(id)));
	}

	[HttpPost]
	public async Task<IActionResult> AddBanner(BannerResult banner)
	{

		var bannerAdded = await mediator.Send(new AddBannerCommand(banner));
		foreach (var productId in banner.ProductIds)
		{
			var bannerProduct = new AddBannerProductResult()
			{ Id = 0, BannerId = bannerAdded.Data.Id, ProductId = productId };
			await mediator.Send(new AddBannerProductCommand(bannerProduct));
		}

		return NewResult(bannerAdded);
	}

	[HttpPut]
	public async Task<IActionResult> UpdateBanner(BannerResult banner)
	{
		var productIds = await repository.GetProductIdsByBannerId(banner.Id);
		foreach (var productId in productIds)
		{
			await mediator.Send(new DeleteBannerProductCommand(banner.Id, productId.Id));
		}
		foreach (var productId in banner.ProductIds)
		{
			var bannerProduct = new AddBannerProductResult()
			{ Id = 0, BannerId = banner.Id, ProductId = productId };
			await mediator.Send(new AddBannerProductCommand(bannerProduct));
		}
		return NewResult(await mediator.Send(new UpdateBannerCommand(banner)));
	}
	[HttpDelete("{id:int}")]
	public async Task<IActionResult> DeleteBanner(int id)
	{
		return NewResult(await mediator.Send(new DeleteBannerCommand(id)));
	}
}