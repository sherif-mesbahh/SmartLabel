using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SmartLabel.Domain.Services;
using System.Data;

namespace SmartLabel.Infrastructure.Services;

public class SqlConnectionFactory(IConfiguration configuration) : ISqlConnectionFactory
{
	private readonly string _connectionString = configuration.GetConnectionString("SqlConnection") ??
												throw new Exception("connection string is missing");
	public IDbConnection Create()
	{
		return new SqlConnection(_connectionString);
	}
}

