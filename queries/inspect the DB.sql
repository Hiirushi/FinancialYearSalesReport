USE TestDB;
GO

-- Q1.Inspect sales data
SELECT TOP 30
    MainGroupingID,
    MainGroupingDesc,
    SubGroupingID,
    SubGroupingDesc,
    CustomerName,
    InvoiceDate,
    FinancialYear,
    FinancialMonth,
    TotalLines,
    TotalSales_FY,
    CompanyID
FROM rpt_Sales
ORDER BY FinancialYear DESC;

--Q2.Salespeople and their records
SELECT
    MainGroupingID,
    MainGroupingDesc,
    SubGroupingID,
    SubGroupingDesc,
    COUNT(*) AS RecordCount
FROM rpt_Sales
GROUP BY
    MainGroupingID,
    MainGroupingDesc,
    SubGroupingID,
    SubGroupingDesc
ORDER BY MainGroupingDesc;

--Q3.Available financial years and months
SELECT
    FinancialYear,
    FinancialMonth,
    COUNT(*) AS RecordCount
FROM rpt_Sales
GROUP BY
    FinancialYear,
    FinancialMonth
ORDER BY
    FinancialYear,
    FinancialMonth;

--Q4.Total sales for each financial year
SELECT
    FinancialYear,
    SUM(TotalLines) AS TotalLinesSum,
    SUM(TotalTax) AS TotalTax,
    SUM(TotalSales_FY) AS TotalSalesFYSum,
    COUNT(*) AS RecordCount
FROM rpt_Sales
GROUP BY FinancialYear
ORDER BY FinancialYear;

--Q5.Compare sales by year, salesperson and customer
SELECT
    FinancialYear,
    MainGroupingDesc AS SalesPerson,
    CustomerName,
    COUNT(*) AS InvoiceRecords,
    SUM(TotalLines + TotalTax) AS TotalSales,
    MAX(TotalSales_FY) AS FinancialYearSales
FROM rpt_Sales
WHERE FinancialYear BETWEEN 2017 AND 2019
GROUP BY
    FinancialYear,
    MainGroupingDesc,
    CustomerName
ORDER BY
    FinancialYear,
    MainGroupingDesc,
    CustomerName;

--Q6.The financial year mapping
SELECT DISTINCT
    FinancialYear,
    FinancialMonth,
    LongMonthName,
    StartingMonth
FROM dim_FinYearCalYearMappingCommon
WHERE FinancialYear BETWEEN 2017 AND 2019
ORDER BY FinancialYear, FinancialMonth;

--Q7.The companies in the sales data
SELECT
    CompanyID,
    COUNT(*) AS TotalRecords
FROM rpt_Sales
GROUP BY CompanyID;

--Q8.Sales by financial month
SELECT
    FinancialYear,
    FinancialMonth,
    MainGroupingDesc AS SalesPerson,
    CustomerName,
    SUM(TotalLines) AS MonthlySales,
    SUM(TotalTax) AS MonthlyTax,
    COUNT(*) AS InvoiceRecords
FROM rpt_Sales
WHERE FinancialYear BETWEEN 2017 AND 2019
GROUP BY
    FinancialYear,
    FinancialMonth,
    MainGroupingDesc,
    CustomerName
ORDER BY
    FinancialYear,
    FinancialMonth,
    MainGroupingDesc,
    CustomerName;

--Q9.The financial-to-calendar mapping
SELECT *
FROM dim_FinYearCalYearMappingCommon
ORDER BY FinancialYear, FinancialMonth;

--Q10.Total sales including tax
SELECT
    FinancialYear,
    SUM(TotalLines) AS SalesExcludingTax,
    SUM(TotalTax) AS TotalTax,
    SUM(TotalLines + TotalTax) AS SalesIncludingTax
FROM rpt_Sales
GROUP BY FinancialYear
ORDER BY FinancialYear;

--Q11.Validate the stored annual sales amounts
SELECT
    FinancialYear,
    MainGroupingDesc AS SalesPerson,
    CustomerName,
    SUM(TotalLines + TotalTax) AS CalculatedSalesIncludingTax,
    MAX(TotalSales_FY) AS StoredFinancialYearSales
FROM rpt_Sales
WHERE FinancialYear BETWEEN 2017 AND 2019
GROUP BY
    FinancialYear,
    MainGroupingDesc,
    CustomerName
ORDER BY
    FinancialYear,
    MainGroupingDesc,
    CustomerName;

--Q12.conflicting values
SELECT
    FinancialYear,
    CustomerName,
    COUNT(*) AS InvoiceCount,
    SUM(TotalLines) AS TotalSalesExcludingTax,
    SUM(TotalTax) AS TotalTax,
    SUM(TotalLines + TotalTax) AS CalculatedSalesIncludingTax,
    MAX(TotalSales_FY) AS StoredFinancialYearSales
FROM rpt_Sales
WHERE
    FinancialYear = 2018
    AND CustomerName = 'A-Z Stationery Supplies'
GROUP BY
    FinancialYear,
    CustomerName;