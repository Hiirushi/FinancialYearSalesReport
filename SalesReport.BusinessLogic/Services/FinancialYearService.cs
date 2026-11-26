using System.Collections.Generic;
using SalesReport.DataAccess.Repositories;
using SalesReport.Models;

namespace SalesReport.BusinessLogic.Services
{
    public class FinancialYearService
    {
        private readonly FinancialYearRepository repository;

        public FinancialYearService()
        {
            repository = new FinancialYearRepository();
        }

        public List<FinancialYearModel> GetPnLFinancialYears()
        {
            return repository.GetPnLFinancialYears();
        }

        public List<FinancialYearModel> GetThreeYearSalesFinancialYears()
        {
            return repository.GetThreeYearSalesFinancialYears();
        }
    }
}