using System;
using System.Collections.Generic;
using System.Configuration;
using Microsoft.Data.SqlClient;
using SalesReport.Models;

namespace SalesReport.DataAccess.Repositories
{
    public class PnLReportRepository
    {
        public List<PnLReportModel> GetPnLReport(
            int financialYear,
            int financialMonth,
            string reportType)
        {
            List<PnLReportModel> reportData =
                new List<PnLReportModel>();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["TestDBConnection"]
                .ConnectionString;

            using (SqlConnection connection =
                new SqlConnection(connectionString))
            {
                //stored procedure command
                using (SqlCommand command =
                    new SqlCommand(
                        "dbo.usp_GetPnL12MonthsReport",
                        connection))
                {
                    command.CommandType =
                        System.Data.CommandType.StoredProcedure;

                    command.Parameters.Add(
                        "@FinancialYear",
                        System.Data.SqlDbType.Int
                    ).Value = financialYear;

                    command.Parameters.Add(
                        "@FinancialMonth",
                        System.Data.SqlDbType.Int
                    ).Value = financialMonth;

                    command.Parameters.Add(
                        "@ReportType",
                        System.Data.SqlDbType.NVarChar,
                        20
                    ).Value = reportType;

                    connection.Open();

                    // executed stored procedure
                    using (SqlDataReader reader =
                        command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            PnLReportModel model =
                                new PnLReportModel();

                            //object mapping
                            model.AccountMapDetailID =
                                Convert.ToInt32(
                                    reader["ksnz_AccountMapDetailID"]);

                            model.DisplayParentID =
                                reader["DisplayParentID"] == DBNull.Value
                                ? (int?)null
                                : Convert.ToInt32(
                                    reader["DisplayParentID"]);

                            model.AccountNumber =
                                reader["AccountNumber"].ToString();

                            model.AccountName =
                                reader["AccountName"].ToString();

                            model.DisplayOrder =
                                Convert.ToInt32(reader["DisplayOrder"]);

                            model.DisplayLevel =
                                Convert.ToInt32(reader["DisplayLevel"]);

                            model.IsTotal =
                                reader["IsTotal"].ToString();

                            model.FinancialYear =
                                Convert.ToInt32(reader["FinancialYear"]);

                            model.FinancialMonth =
                                Convert.ToInt32(reader["FinancialMonth"]);

                            model.LongMonthName =
                                reader["LongMonthName"].ToString();

                            model.Amount =
                                reader["Amount"] == DBNull.Value
                                ? 0m
                                : Convert.ToDecimal(reader["Amount"]);

                            model.TwelveMonthTotal =
                                reader["TwelveMonthTotal"] == DBNull.Value
                                ? 0m
                                : Convert.ToDecimal(
                                    reader["TwelveMonthTotal"]);

                            reportData.Add(model);
                        }
                    }
                }
            }

            return reportData;
        }
    }
}
