using System.Data;

namespace SmartLabel.Application.Services;
public interface ISqlConnectionFactory
{
	public IDbConnection Create();
}