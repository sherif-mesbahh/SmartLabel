using Microsoft.EntityFrameworkCore.Storage;
using SmartLabel.Domain.Interfaces;
using SmartLabel.Infrastructure.Persistence.Data;
using System.Data;

namespace SmartLabel.Infrastructure.Interfaces;
public class UnitOfWork(AppDbContext context) : IUnitOfWork
{
	public async Task SaveChangesAsync(CancellationToken cancellationToken = default)
	{
		await context.SaveChangesAsync(cancellationToken);
	}

	public async Task<IDbTransaction> BeginTransaction()
	{
		try
		{
			var transaction = await context.Database.BeginTransactionAsync();
			return transaction.GetDbTransaction();
		}
		catch (Exception ex)
		{
			throw new InvalidOperationException("Failed to begin a database transaction.", ex);
		}
	}
}
