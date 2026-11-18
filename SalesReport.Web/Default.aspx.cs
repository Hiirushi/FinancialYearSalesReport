using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;

namespace SalesReport.Web
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = false)]
        public static List<int> GetFinancialYears()
        {
            List<int> financialYears = new List<int>();

            string connectionString =
                ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT DISTINCT FinancialYear
            FROM dbo.rpt_Sales
            WHERE FinancialYear >= (
                SELECT MIN(FinancialYear) + 2
                FROM dbo.rpt_Sales
            )
            ORDER BY FinancialYear;";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            financialYears.Add(Convert.ToInt32(reader["FinancialYear"]));
                        }
                    }
                }
            }

            return financialYears;
        }
    }
}