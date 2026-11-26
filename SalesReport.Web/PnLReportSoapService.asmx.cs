using SalesReport.BusinessLogic.Services;
using SalesReport.Models;
using System.Collections.Generic;
using System.Web.Services;

namespace SalesReport.Web
{
    //xml namespace used to identify the web service 
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class PnLReportSoapService : WebService
    {
        [WebMethod]
        public PnLReportModel[] GetPnLReport(
            int financialYear,
            int financialMonth,
            string reportType)
        {
            PnLReportService service = new PnLReportService();

            List<PnLReportModel> reportData =
                service.GetPnLReport(
                    financialYear,
                    financialMonth,
                    reportType
                );

            return reportData.ToArray();
        }
    }
}
