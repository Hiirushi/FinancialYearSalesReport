--all months-actual
EXEC dbo.usp_GetPnL12MonthsReport
    @FinancialYear = 2018,
    @FinancialMonth = 0,
    @ReportType = 'Actual';

--spcific month -july budget
EXEC dbo.usp_GetPnL12MonthsReport
    @FinancialYear = 2018,
    @FinancialMonth = 1,
    @ReportType = 'Budget';

--test forecast
EXEC dbo.usp_GetPnL12MonthsReport
    @FinancialYear = 2018,
    @FinancialMonth = 0,
    @ReportType = 'Forecast';

--invalid report type
EXEC dbo.usp_GetPnL12MonthsReport
    @FinancialYear = 2018,
    @FinancialMonth = 0,
    @ReportType = 'Sales';