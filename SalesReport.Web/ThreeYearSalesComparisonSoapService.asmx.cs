
using SalesReport.BusinessLogic.Services;
using SalesReport.Models;
using System.Collections.Generic;
using System.Web.Services;

namespace SalesReport.Web
{
    // XML namespace used to identify the web service
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ThreeYearSalesComparisonSoapService : WebService
    {
        [WebMethod]
        public ThreeYearSalesReportModel[] GetThreeYearSalesComparison(
            int financialYear,
            int financialMonth,
            string selectionType)
        {
            ThreeYearSalesService service =
                new ThreeYearSalesService();

            List<ThreeYearSalesReportModel> reportData =
                service.GetThreeYearSalesComparison(
                    financialYear,
                    financialMonth,
                    selectionType
                );

            return reportData.ToArray();
        }
    }
}
