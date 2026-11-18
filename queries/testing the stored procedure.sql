USE TestDB;
GO

--test month selection
EXEC dbo.usp_GetThreeYearSalesComparison
    @FinancialYear = 2019,
    @FinancialMonth = 5,
    @SelectionType = 'MONTH';

--test year to date selection
EXEC dbo.usp_GetThreeYearSalesComparison
    @FinancialYear = 2019,
    @FinancialMonth = 5,
    @SelectionType = 'YTD';

--test invalid inputs
EXEC dbo.usp_GetThreeYearSalesComparison
    @FinancialYear = 2019,
    @FinancialMonth = 15,
    @SelectionType = 'MONTH';

--total sales for financial month
SELECT
	FinancialYear,
	SUM(ISNULL(TotalLines, 0) + ISNULL(TotalTax, 0)) AS TotalSales
FROM dbo.rpt_Sales
WHERE
	FinancialYear BETWEEN 2017 AND 2019
	AND FinancialMonth = 5
GROUP BY FinancialYear
ORDER BY FinancialYear;

--total sales YTD version
SELECT
    FinancialYear,
    SUM(ISNULL(TotalLines, 0) + ISNULL(TotalTax, 0)) AS TotalSales
FROM dbo.rpt_Sales
WHERE
    FinancialYear BETWEEN 2017 and 2019
    AND FinancialMonth BETWEEN 1 AND 5
GROUP BY FinancialYear
ORDER BY FinancialYear;