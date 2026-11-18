<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SalesReport.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid p-4">

        <!-- Page Heading -->
        <div class="mb-4">
            <h2>Three Year Sales Comparison</h2>
        </div>


        <!-- Filter Section -->
        <div class="card shadow-sm mb-4">

            <div class="card-header">
                <h5 class="mb-0">Report Parameters</h5>
            </div>

            <div class="card-body">

                <!-- Report Title -->
                <div class="row mb-3">

                    <div class="col-md-5">
                        <label for="reportTitle">Report Title</label>
                        <input id="reportTitle" />
                    </div>

                </div>

                <hr />

                <!--  Report Filters -->
                <div class="row">

                    <div class="col-md-4 mb-3">
                        <label for="financialYear">Financial Year</label>
                        <select id="financialYear"></select>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label for="financialMonth">Financial Month</label>
                        <input id="financialMonth" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label for="selectionType">Selection Type</label>
                        <input id="selectionType" />
                    </div>

                </div>

                <hr />

                <!-- Options and Apply Button -->
                <div class="row align-items-center">

                    <div class="col-md-6 mb-2 mb-md-0">
                        <input type="checkbox" id="expandDetails" />
                        <label for="expandDetails" class="mb-0">
                            Expand customer details
               
                        </label>
                    </div>

                    <div class="col-md-6 text-md-end">
                        <button type="button" id="applyFilters">
                            Apply Filters
               
                        </button>
                    </div>

                </div>

            </div>
        </div>


        <!-- Report section-->
        <div class="card shadow-sm">
            <div class="card-header">
                <h5 class="mb-0">Three Year Sales Comparison Report</h5>
            </div>
        </div>

        <div class="card-body">
            <div id="reportPlaceholder" class="text-center text-muted p-5">
                <h5>No Report Generated</h5>
                <p>Select the report parameters and click Apply Filters</p>
            </div>

            <div id="reportLoading" class="text-center p-4" style="display: none;">
                <div class="spinner-border text-bg-danger primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>

                <p class="text-muted mt-2">
                    Generating your sales report...
                </p>
            </div>

            <iframe id="reportFrame" style="display: none; width: 100%; height: 850px; border: none;"></iframe>
        </div>
    </div>

</asp:Content>
