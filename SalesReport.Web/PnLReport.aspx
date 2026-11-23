<%@ Register Assembly="Microsoft.ReportViewer.WebForms"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>

<%@ Page Title="P&L Report" Language="C#" 
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true" 
    CodeBehind="PnLReport.aspx.cs" 
    Inherits="SalesReport.Web.PnLReport" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid p-4">
        <div class="mb-4">
            <h2>Profit & Loss - 12 Months Report</h2>
        </div>

        <rsweb:ReportViewer
            ID="ReportViewer"
            runat="server"
            Width="100%"
            Height="900px"
            ProcessingMode="Remote"
            AsyncRendering="true"
            SizeToReportContent="false">
        </rsweb:ReportViewer>
    </div>
</asp:Content>