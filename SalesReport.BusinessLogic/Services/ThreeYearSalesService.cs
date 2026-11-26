using SalesReport.DataAccess.Repositories;
using SalesReport.Models;
using System;
using System.Collections.Generic;

namespace SalesReport.BusinessLogic.Services
{
    public class ThreeYearSalesService
    {
        private readonly ThreeYearSalesReportRepository repository;
        public ThreeYearSalesService()
        {
            repository = new ThreeYearSalesReportRepository();
        }

        public List<ThreeYearSalesReportModel> GetThreeYearSalesComparison(
            int financialYear,
            int financialMonth,
            string selectionType
            )
        {
            if (financialYear <= 0)
            {
                throw new ArgumentException($"Invalid financial year: {financialYear}");
            }

            if (financialMonth < 1 || financialMonth > 12)
            {
                throw new ArgumentException($"Invalid financial month:{financialMonth}");
            }

            if (string.IsNullOrWhiteSpace(selectionType))
            {
                throw new ArgumentException("Selection type is required");
            }

            selectionType = selectionType.Trim().ToUpperInvariant();

            if (selectionType != "MONTH" &&
                selectionType != "YTD" &&
                selectionType != "YEAR TO DATE")
            {
                throw new ArgumentException(
                    "Invalid selection type. Use MONTH or YTD");
            }

            return repository.GetThreeYearSalesComparison(
                financialYear,
                financialMonth,
                selectionType);
        }
    }
}
