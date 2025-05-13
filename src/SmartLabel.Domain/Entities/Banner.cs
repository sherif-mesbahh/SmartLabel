﻿namespace SmartLabel.Domain.Entities;
public class Banner
{
	public int Id { get; set; }
	public string Title { get; set; }

	public string? Description { get; set; }
	public DateTime StartDate { get; set; }
	public DateTime EndDate { get; set; }
	public string? MainImage { get; set; }
	public bool IsActive { get; set; }
	public ICollection<BannerImage>? Images { get; set; }
}
