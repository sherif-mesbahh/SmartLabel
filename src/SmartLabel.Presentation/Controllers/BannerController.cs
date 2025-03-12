using MediatR;
using Microsoft.AspNetCore.Mvc;
using SmartLabel.Application.Features.BannerProducts.Command.Models;
using SmartLabel.Application.Features.BannerProducts.Command.Results;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Application.Features.Banners.Command.Results;
using SmartLabel.Presentation.Base;

namespace SmartLabel.Presentation.Controllers;

[Route("api/[controller]")]
[ApiController]
public class BannerController(IMediator mediator) : AppControllerBase
{
	[HttpPost]
	public async Task<IActionResult> AddBanner(AddBannerResult banner)
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
}