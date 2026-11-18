$(document).ready(function () {
    //report title inputs
    $("#reportTitle").kendoTextBox({
        placeholder: "Wengh Spring Pvt Ltd"
    });

    //expand checkbox
    $("#expandDetails").kendoCheckBox();

    // Financial year dropdown
    $.ajax({
        type: "POST",
        url: "Default.aspx/GetFinancialYears",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            var years = response.d;

            var yearData = years.map(function (year) {
                return {
                    text: "FY" + year,
                    value: year
                };
            });

            $("#financialYear").kendoDropDownList({
                dataSource: yearData,
                dataTextField: "text",
                dataValueField: "value",
                value: years.includes(2019) ? 2019 : years[years.length - 1]
            });
        },

        error: function (xhr, status, error) {
            console.error("Error:", error);
            console.error("Server Response:", xhr.responseText);

            alert("Unable to load financial years. Check the browser console.");
        }
    });

    //financial month dropdown
    $("#financialMonth").kendoDropDownList({
        dataSource: [
            { text: "July", value: 1 },
            { text: "August", value: 2 },
            { text: "September", value: 3 },
            { text: "October", value: 4 },
            { text: "November", value: 5 },
            { text: "December", value: 6 },
            { text: "January", value: 7 },
            { text: "February", value: 8 },
            { text: "March", value: 9 },
            { text: "April", value: 10 },
            { text: "May", value: 11 },
            { text: "June", value: 12 }
        ],
        dataTextField: "text",
        dataValueField: "value",
        value: 5
    });

    // Selection Type
    $("#selectionType").kendoDropDownList({
        dataSource: [
            { text: "Month", value: "MONTH" },
            { text: "Year To Date", value: "YTD" }
        ],
        dataTextField: "text",
        dataValueField: "value",
        value: "MONTH"
    });

    //initialize kendo button
    $("#applyFilters").kendoButton({
        themeColor: "primary"
    });

    //get selected values from kendo dropdowns
    $("#applyFilters").click(function () {
        var reportTitle = $("#reportTitle").data("kendoTextBox").value().trim();
        if (reportTitle === "") {
            reportTitle = "Wengh Spring Pvt Ltd";
        }
        var financialYear = $("#financialYear").data("kendoDropDownList").value();
        var financialMonth = $("#financialMonth").data("kendoDropDownList").value();
        var selectionType = $("#selectionType").data("kendoDropDownList").value();
        var expandDetails = $("#expandDetails").is(":checked");

        var reportUrl = "http://localhost/ReportServer?/SalesReport/ThreeYearSalesComparison"
            + "&FinancialYear=" + encodeURIComponent(financialYear) +
            "&FinancialMonth=" + encodeURIComponent(financialMonth) +
            "&SelectionType=" + encodeURIComponent(selectionType) +
            "&ReportTitle=" + encodeURIComponent(reportTitle) +
            "&ExpandDetails=" + encodeURIComponent(expandDetails.toString()) +
            "&rs:Command=Render" +
            "&rs:Embed=true";

        //show loading indicator
        $("#reportPlaceholder").hide();
        $("#reportFrame").hide();
        $("#reportLoading").show()

        //load report
        $("#reportFrame").off("load").on("load", function () {
            $("#reportLoading").hide();
            $("#reportFrame").show();
        }).attr("src", reportUrl);
    });
});