using SalesReport.Models;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Configuration;
using System.Data;

namespace SalesReport.DataAccess.Repositories
{
    public class FinancialYearRepository
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;

        public List<FinancialYearModel> GetPnLFinancialYears()
        {
            return GetFinancialYears("usp_GetPnLFinancialYears");
        }

        public List<FinancialYearModel> GetThreeYearSalesFinancialYears()
        {
            return GetFinancialYears("usp_GetThreeYearSalesFinancialYears");
        }

        private List<FinancialYearModel> GetFinancialYears(string storedProcedure)
        {
            var financialYears = new List<FinancialYearModel>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(storedProcedure, connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        financialYears.Add(new FinancialYearModel
                        {
                            FinancialYear = reader.GetInt32(
                                reader.GetOrdinal("FinancialYear"))
                        });
                    }
                }
            }

            return financialYears;
        }
    }
}
