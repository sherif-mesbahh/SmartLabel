using AutoMapper;
using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Models;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Domain.Repositories;
using SmartLabel.Domain.Services;

namespace SmartLabel.Application.Features.Banners.Command.Handlers;
public class AddBannerHandler(IMapper mapper, IBannerRepository repository, IFileService fileService, IUnitOfWork unitOfWork)
	: ResponseHandler, IRequestHandler<AddBannerCommand, Response<string>>
{
	public async Task<Response<string>> Handle(AddBannerCommand request, CancellationToken cancellationToken)
	{
		using var transaction = await unitOfWork.BeginTransaction();
		try
		{
			var banner = mapper.Map<Banner>(request);
			await repository.AddBanner(banner);
			await unitOfWork.SaveChangesAsync(cancellationToken);
			if (request.ImagesFiles is not null)
			{
				foreach (var image in request.ImagesFiles)
				{
					var bannerImage = new BannerImage()
					{
						Id = 0,
						ImageUrl = await fileService.BuildImageAsync(image),
						BannerId = banner.Id
					};
					await repository.AddBannerImage(bannerImage);
				}
			}

			await unitOfWork.SaveChangesAsync(cancellationToken);
			transaction.Commit();
			return Created<string>("Banner is added successfully");
		}
		catch (Exception ex)
		{
			transaction.Rollback();
			return InternalServerError<string>($"An error occurred: {ex.Message}");
		}
	}
}
