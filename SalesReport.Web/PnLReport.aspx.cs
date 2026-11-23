using System;
using System.Web.UI;
using Microsoft.Reporting.WebForms;

namespace SalesReport.Web
{
    public partial class PnLReport : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ReportViewer.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
                ReportViewer.ServerReport.ReportServerUrl =
                    new Uri("http://localhost/ReportServer");

                ReportViewer.ServerReport.ReportPath =
                    "/SalesReport/PnL12Months";
            }
        }
    }
}