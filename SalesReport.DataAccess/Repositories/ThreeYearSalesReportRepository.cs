using SalesReport.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace SalesReport.DataAccess.Repositories
{
    public class ThreeYearSalesReportRepository
    {
        public List<ThreeYearSalesReportModel> GetThreeYearSalesComparison(
            int financialYear,
            int financialMonth,
            string selectionType)
        {
            List<ThreeYearSalesReportModel> reportData = new List<ThreeYearSalesReportModel>();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["TestDBConnection"]
                .ConnectionString;

            using(SqlConnection connection = 
                    new SqlConnection(connectionString))
                    { 
                        using (SqlCommand command = 
                        new SqlCommand(
                            "dbo.usp_GetThreeYearSalesComparison",
                            connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    command.Parameters.Add(
                        "@FinancialYear",
                        System.Data.SqlDbType.Int
                        ).Value = financialYear;

                    command.Parameters.Add(
                        "@FinancialMonth",
                        System.Data.SqlDbType.Int
                        ).Value = financialMonth;

                    command.Parameters.Add(
                        "@SelectionType",
                        System.Data.SqlDbType.VarChar,20
                        ).Value = selectionType;

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while( reader.Read())
                        {
                            ThreeYearSalesReportModel model = 
                                new ThreeYearSalesReportModel();

                            model.SalesPerson =
                                reader["SalesPerson"].ToString();

                            model.CustomerName =
                                reader["CustomerName"].ToString();
                            
                            model.PreviousYear2Sales =
                                Convert.ToDecimal(
                                reader["PreviousYear2Sales"]);

                            model.PreviousYear1Sales =
                                Convert.ToDecimal(
                                reader["PreviousYear1Sales"]);

                            model.PreviousYear2Sales =
                                Convert.ToDecimal(
                                reader["PreviousYear2Sales"]);

                            model.SelectedYearSales =
                                Convert.ToDecimal(
                                 reader["SelectedYearSales"]);

                            reportData.Add(model);
                        }
                    }
                }
            }
            return reportData;
        }
    }
}
