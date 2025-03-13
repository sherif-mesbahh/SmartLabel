using SmartLabel.Domain.Entities;

namespace SmartLabel.Domain.Repositories
{
	public interface IStoredProceduresRepository
	{
		public Task<IEnumerable<GetProductIdsByBannerId>> GetProductIdsByBannerId(int id);
	}
}
