USE TestDB;
GO

--SP to get financial years
CREATE PROCEDURE usp_GetPnLFinancialYears
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        FinancialYear
    FROM rpt_PnL_Default
    WHERE CompanyID = 401
    ORDER BY FinancialYear DESC;
END;

EXEC usp_GetPnLFinancialYears;

--SP for P&L 12 months report
CREATE PROCEDURE usp_GetPnL12MonthsReport
    @FinancialYear INT,
    @FinancialMonth INT = 0,
    @ReportType NVARCHAR(20) = 'Actual'
AS
BEGIN
    SET NOCOUNT ON;

    --validate reportt type
    IF @ReportType NOT IN ('Actual', 'Budget', 'Forecast')
    BEGIN
        ;THROW 50001, 'Invalid report type.', 1;
    END;

    --create the ReportData Common Table Expression(CTE)
    ;WITH ReportData AS
    (
        SELECT
            P.ksnz_AccountMapDetailID,
            P.ksnz_AccountMapDetailParentID AS DisplayParentID,
            P.AccountNumber,
            P.AccountName,
            P.DisplayOrder,
            P.DisplayLevel,
            P.IsTotal,
            P.FinancialYear,
            P.FinancialMonth,
            C.LongMonthName,

            --select type
            CASE @ReportType
                WHEN 'Actual' THEN P.Actual
                WHEN 'Budget' THEN P.Budget
                WHEN 'Forecast' THEN P.Forecast
            END AS Amount --given the common name Amount

        FROM rpt_PnL_Default P

        --account details
        INNER JOIN KSNZ_AccountMapDetail D
            ON P.ksnz_AccountMapDetailID = D.ID

        --parent account
        LEFT JOIN KSNZ_AccountMapDetail Parent
            ON P.ksnz_AccountMapDetailParentID = Parent.ID
        
        --report configuration
        INNER JOIN KSNZ_AccountMapHeader H
            ON P.ksnz_AccountMapHeaderID = H.ID

        --financial calendar
        INNER JOIN dim_FinYearCalYearMappingCommon C
            ON P.dimFinYearCalYearID = C.ID

        WHERE P.FinancialYear = @FinancialYear
          AND P.CompanyID = 401
          AND H.ReportKey = 'PNL'
          AND H.ViewName = 'Default'
    )

    --calculate the 12-month total
    SELECT
        *,
        SUM(Amount) OVER (
            PARTITION BY ksnz_AccountMapDetailID
        ) AS TwelveMonthTotal

    FROM ReportData

    --financial month filter
    WHERE @FinancialMonth = 0 --all 12 months
       OR FinancialMonth = @FinancialMonth

    --sorts according to the predefined display order then monthly order
    ORDER BY DisplayOrder, FinancialMonth;
END;

EXEC usp_GetPnL12MonthsReport
    @FinancialYear = 2020,
    @FinancialMonth = 0,
    @ReportType = 'Actual';