using System.Data;

namespace SmartLabel.Domain.Services;
public interface ISqlConnectionFactory
{
	public IDbConnection Create();
}