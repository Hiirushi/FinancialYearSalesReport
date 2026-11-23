USE TestDB

--inspecting the tables and columns
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
    'rpt_PnL_Default',
    'rpt_BalanceSheet',
    'dim_FinYearCalYearMappingCommon',
    'KSNZ_AccountMapHeader',
    'KSNZ_AccountMapDetail'
)
ORDER BY TABLE_NAME, ORDINAL_POSITION;

--inspecting the P&L table
SELECT TOP 30
    ID,
    ksnz_AccountMapHeaderID,
    ksnz_AccountMapDetailID,
    ksnz_AccountMapDetailParentID,
    AccountNumber,
    AccountName,
    FinancialYear,
    FinancialMonth,
    LongMonthName,
    Actual,
    AccountLevel,
    DisplayLevel,
    IsTotal,
    CompanyID
FROM rpt_PnL_Default
ORDER BY
    FinancialYear,
    FinancialMonth,
    DisplayOrder;

--get the number of records in each year
SELECT
    FinancialYear,
    CompanyID,
    COUNT(*) AS RecordCount
FROM rpt_PnL_Default
GROUP BY
    FinancialYear,
    CompanyID
ORDER BY
    FinancialYear,
    CompanyID;

--investigate the P&L report data for a specific financial year and month
SELECT TOP 30
    P.AccountNumber,
    P.AccountName,
    P.AccountLevel,
    P.DisplayLevel,
    P.Actual,
    P.FinancialYear,
    P.FinancialMonth,
    D.AccountName AS MappedAccountName,
    Parent.AccountName AS ParentAccountName,
    H.ViewName,
    H.ReportKey,
    C.LongMonthName
FROM rpt_PnL_Default P

--account details join
LEFT JOIN KSNZ_AccountMapDetail D
    ON P.ksnz_AccountMapDetailID = D.ID

--parent account join
LEFT JOIN KSNZ_AccountMapDetail Parent
    ON P.ksnz_AccountMapDetailParentID = Parent.ID

--report header join
LEFT JOIN KSNZ_AccountMapHeader H
    ON P.ksnz_AccountMapHeaderID = H.ID

--financial calendar join
LEFT JOIN dim_FinYearCalYearMappingCommon C
    ON P.dimFinYearCalYearID = C.ID

WHERE P.FinancialYear = 2018
AND P.FinancialMonth = 1
AND P.CompanyID = 401

ORDER BY P.DisplayOrder;

--checks a specific account has financial records across the 12 months
SELECT
    AccountNumber,
    AccountName,
    FinancialYear,
    COUNT(DISTINCT FinancialMonth) AS MonthCount,
    MIN(FinancialMonth) AS FirstMonth,
    MAX(FinancialMonth) AS LastMonth,
    SUM(Actual) AS TotalActual
FROM rpt_PnL_Default
WHERE FinancialYear = 2018
  AND CompanyID = 401
  AND AccountNumber IN ('4-0000', '4-1000', '4-1100')
GROUP BY
    AccountNumber,
    AccountName,
    FinancialYear
ORDER BY AccountNumber;

--checks the months for a financial year
SELECT DISTINCT
    FinancialYear,
    FinancialMonth,
    LongMonthName
FROM rpt_PnL_Default
WHERE FinancialYear = 2018
  AND CompanyID = 401
ORDER BY FinancialMonth;

--investigate account hierarchy and display structure
SELECT
    AccountNumber,
    AccountName,
    ksnz_AccountMapDetailID,
    ksnz_AccountMapDetailParentID,
    AccountLevel,
    DisplayLevel,
    DisplayOrder,
    IsTotal
FROM rpt_PnL_Default
WHERE FinancialYear = 2018
  AND FinancialMonth = 1
  AND CompanyID = 401
ORDER BY DisplayOrder;

--explores p&l report configurations
SELECT
    ID,
    ReportKey,
    ViewName,
    EffectiveFinancialYear,
    DisplayLevel,
    CompanyID
FROM KSNZ_AccountMapHeader
WHERE ReportKey = 'PNL'
ORDER BY EffectiveFinancialYear, ViewName;

--monthly actual income for one specific account throughout a year
SELECT
    AccountNumber,
    AccountName,
    FinancialMonth,
    LongMonthName,
    Actual
FROM rpt_PnL_Default
WHERE FinancialYear = 2018
  AND CompanyID = 401
  AND AccountNumber = '4-1100'
ORDER BY FinancialMonth;

--financial years
SELECT DISTINCT
    FinancialYear
FROM rpt_PnL_Default
WHERE CompanyID = 401
ORDER BY FinancialYear;

--how the database stores actual financial results, budget, forecasts and variance
SELECT TOP 20
    AccountNumber,
    AccountName,
    Actual,
    Budget,
    Forecast,
    Variance,
    FinancialYear,
    FinancialMonth
FROM rpt_PnL_Default
WHERE FinancialYear = 2018
  AND FinancialMonth = 1
  AND CompanyID = 401
ORDER BY DisplayOrder;

--retreive all the column names in p&l default table
SELECT
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'rpt_PnL_Default'
ORDER BY ORDINAL_POSITION;

