
namespace SalesReport.Models
{
    public class PnLReportModel
    {
        public int AccountMapDetailID { get; set; }

        public int? DisplayParentID { get; set; }

        public string AccountNumber { get; set; }

        public string AccountName { get; set; }

        public int DisplayOrder { get; set; }

        public int DisplayLevel { get; set; }

        public string IsTotal { get; set; }

        public int FinancialYear { get; set; }

        public int FinancialMonth { get; set; }

        public string LongMonthName { get; set; }

        public decimal Amount { get; set; }

        public decimal TwelveMonthTotal { get; set; }
    }
}
