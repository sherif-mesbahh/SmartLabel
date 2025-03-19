using System.Data;

namespace SmartLabel.Domain.Interfaces;
public interface IUnitOfWork
{
	Task SaveChangesAsync(CancellationToken cancellationToken = default);
	Task<IDbTransaction> BeginTransaction();
}