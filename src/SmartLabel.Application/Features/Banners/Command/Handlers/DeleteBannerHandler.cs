using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class DeleteBannerHandler(IBannerRepository repository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<DeleteBannerCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteBannerCommand request, CancellationToken cancellationToken)
	{
		if (!await repository.IsBannerExist(request.Id))
		{
			return NotFound<string>($"The Banner with id {request.Id} is not found");
		}

		try
		{
			var banner = await repository.GetBannerById(request.Id);
			if (banner?.Images is not null)
			{
				foreach (var image in banner.Images)
				{
					await fileService.DeleteImageAsync(image.ImageUrl);
				}
			}

			repository.DeleteBanner(banner);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			return Deleted<string>("This banner is deleted Successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}
