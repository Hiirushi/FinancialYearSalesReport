using System.Web.Services;
using SalesReport.BusinessLogic.Services;
using SalesReport.Models;
using System.Linq;

namespace SalesReport.Web
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class FinancialYearSoapService : WebService
    {
        private readonly FinancialYearService service =
            new FinancialYearService();

        [WebMethod]
        public FinancialYearModel[] GetPnLFinancialYears()
        {
            return service.GetPnLFinancialYears().ToArray();
        }

        [WebMethod]
        public FinancialYearModel[] GetThreeYearSalesFinancialYears()
        {
            return service.GetThreeYearSalesFinancialYears().ToArray();
        }
    }
}