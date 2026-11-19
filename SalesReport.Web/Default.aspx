<%@ Register Assembly="Microsoft.ReportViewer.WebForms"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>

<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="SalesReport.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid p-4">
        <div class="mb-4">
            <h2>Three Year Sales Comparison</h2>
        </div>

        <rsweb:ReportViewer
            ID="ReportViewer"
            runat="server"
            Width="100%"
            Height="800px"
            ProcessingMode="Remote"
            AsyncRendering="true">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
