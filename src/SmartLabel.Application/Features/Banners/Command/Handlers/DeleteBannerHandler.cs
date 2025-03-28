using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class DeleteBannerHandler(IBannerRepository bannerRepository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<DeleteBannerCommand, Response<string>>
{
	public async Task<Response<string>> Handle(DeleteBannerCommand request, CancellationToken cancellationToken)
	{
		var banner = await bannerRepository.GetBannerByIdAsync(request.Id);
		if (banner is null)
			return NotFound<string>($"Banner with id {request.Id} is not found");

		try
		{
			if (banner.Images is not null)
			{
				foreach (var image in banner.Images)
					await fileService.DeleteImageAsync(image);
			}

			await bannerRepository.DeleteBannerAsync(request.Id);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			return Deleted<string>($"banner with id {request.Id} is deleted Successfully");
		}
		catch (Exception ex)
		{
			return InternalServerError<string>($"{ex.Message}");
		}
	}
}
