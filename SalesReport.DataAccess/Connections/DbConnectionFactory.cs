using System.Configuration;
using System.Data.SqlClient;

namespace SalesReport.DataAccess.Connections
{
    public class DbConnectionFactory
    {
        private readonly string _connectionString;

        public DbConnectionFactory()
        {
            _connectionString = ConfigurationManager
                .ConnectionStrings["TestDBConnection"]
                .ConnectionString;
        }

        public SqlConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}
