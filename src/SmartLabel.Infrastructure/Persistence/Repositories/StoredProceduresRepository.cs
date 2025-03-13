using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using SmartLabel.Domain.Entities;
using SmartLabel.Domain.Repositories;
using SmartLabel.Infrastructure.Persistence.Data;

namespace SmartLabel.Infrastructure.Persistence.Repositories
{
	public class StoredProceduresRepository(AppDbContext context) : IStoredProceduresRepository

	{
		public async Task<IEnumerable<GetProductIdsByBannerId>> GetProductIdsByBannerId(int id)
		{
			var bannerIdParam = new SqlParameter("@BannerId", id);

			var result = await context.ProductIds
				.FromSqlRaw("EXEC dbo.GetProductIdsByBannerID @BannerId", bannerIdParam)
				.ToListAsync();

			return result;
		}

	}
}
