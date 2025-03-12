using MediatR;
using SmartLabel.Application.Bases;
using SmartLabel.Application.Features.Banners.Command.Results;

namespace SmartLabel.Application.Features.Banners.Command.Models
{
	public class AddBannerCommand : IRequest<Response<AddBannerCommand>>
	{
		public int Id { get; set; }
		public string Title { get; set; }
		public string? Description { get; set; }
		public DateTime StartDate { get; set; }
		public DateTime EndDate { get; set; }

		public AddBannerCommand(AddBannerResult banner)
		{
			Id = banner.Id;
			Title = banner.Title;
			Description = banner.Description;
			StartDate = banner.StartDate;
			EndDate = banner.EndDate;
		}
	}
}
