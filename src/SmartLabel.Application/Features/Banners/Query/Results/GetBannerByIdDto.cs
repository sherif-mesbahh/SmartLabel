﻿namespace SmartLabel.Application.Features.Banners.Query.Results;

public class GetBannerByIdDto
{
	public required string Title { get; set; }
	public string? Description { get; set; }
	public DateTime StartDate { get; set; }
	public DateTime EndDate { get; set; }
	public List<string>? Images { get; set; }
}