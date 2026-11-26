
namespace SalesReport.Models
{
    public class ThreeYearSalesReportModel
    {
        public string SalesPerson { get; set; }
        public string CustomerName { get; set; }
        public decimal PreviousYear2Sales { get; set; }
        public decimal PreviousYear1Sales { get; set; }
        public decimal SelectedYearSales { get; set; }
    }
}
