using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Results;

namespace SmartLabel.Application.Features.Banners.Command.Models
{
	public class UpdateBannerCommand : IRequest<Response<string>>
	{
		public int Id { get; set; }
		public string Title { get; set; }
		public string? Description { get; set; }
		public DateTime StartDate { get; set; }
		public DateTime EndDate { get; set; }

		public UpdateBannerCommand(BannerResult banner)
		{
			Id = banner.Id;
			Title = banner.Title;
			Description = banner.Description;
			StartDate = banner.StartDate;
			EndDate = banner.EndDate;
		}
	}
}
