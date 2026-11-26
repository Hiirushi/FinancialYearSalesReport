using SalesReport.DataAccess.Repositories;
using SalesReport.Models;
using System;
using System.Collections.Generic;

namespace SalesReport.BusinessLogic.Services
{
    public class PnLReportService
    {
        private readonly PnLReportRepository _repository;

        public PnLReportService()
        {
            _repository = new PnLReportRepository();
        }

        public List<PnLReportModel> GetPnLReport(
            int financialYear,
            int financialMonth,
            string reportType)
        {
            //validates the parameters
            if (financialYear <= 0)
            {
                throw new ArgumentException(
                    $"Invalid financial year received from SSRS: {financialYear}");
            }

            if (financialMonth < 0 || financialMonth > 12)
            {
                throw new ArgumentException(
                    "Financial month must be between 0 and 12.");
            }

            if (string.IsNullOrWhiteSpace(reportType))
            {
                throw new ArgumentException(
                    "Report type is required.");
            }

            reportType = reportType.Trim();

            if (reportType != "Actual" &&
                reportType != "Budget" &&
                reportType != "Forecast")
            {
                throw new ArgumentException(
                    "Invalid report type.");
            }

            return _repository.GetPnLReport(
                financialYear,
                financialMonth,
                reportType);
        }
    }
}
