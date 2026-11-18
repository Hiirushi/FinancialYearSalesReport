USE TestDB;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetThreeYearSalesComparison
	@FinancialYear INT,
	@FinancialMonth INT,
	@SelectionType VARCHAR(20)
AS
BEGIN
	--prevents SQL server from returning messages
	SET NOCOUNT ON;

	-- 1. validate the financial month
	IF @FinancialMonth < 1 OR @FinancialMonth > 12
	BEGIN
		RAISERROR('Financial month must be between 1 and 12.', 16, 1);
		RETURN;
	END;

	-- 2. validate the selection type
	SET @SelectionType = UPPER(LTRIM(RTRIM(@SelectionType)));

	IF @SelectionType NOT IN ('MONTH','YTD','YEAR TO DATE')
	BEGIN
		RAISERROR('SELECTION type must be Month or Year To Date',16, 1);
		RETURN;
	END;

	--3. retrieve and aggregate the sales data
	SELECT
		--returns the first non-null value
		COALESCE(
			NULLIF(LTRIM(RTRIM(MainGroupingDesc)), ''),
			'Unassigned'
		) AS SalesPerson,

		COALESCE(
			NULLIF(LTRIM(RTRIM(CustomerName)), ''),
			'Unknown Customer'
		) AS CustomerName,
		
		-- two years before the selected financial year
		SUM(
			CASE
				WHEN FinancialYear = @FinancialYear - 2
				THEN ISNULL(TotalLines,0) + ISNULL(TotalTax,0)
				ELSE 0
			END
		) AS PreviousYear2Sales,

		-- one year before the selected finacial year
		SUM(
			CASE
				WHEN FinancialYear = @FinancialYear - 1
				THEN ISNULL(TotalLines, 0) + ISNULL(TotalTax, 0)
				ELSE 0
			END
		) AS PreviousYear1Sales,

		-- selected financial year
		SUM(
			CASE
				WHEN FinancialYear = @FinancialYear
				THEN ISNULL(TotalLines, 0) + ISNULL(TotalTax, 0)
				ELSE 0
			END
		) AS SelectedYearSales

		FROM dbo.rpt_Sales

		WHERE
			FinancialYear BETWEEN @FinancialYear - 2 AND @FinancialYear
			--filter by selection type
			AND
			(
				(
					@SelectionType = 'MONTH'
					AND FinancialMonth = @FinancialMonth
				)
				OR
				(
					@SelectionType IN ('YTD', 'YEAR TO DATE')
					AND FinancialMonth BETWEEN 1 AND @FinancialMonth
				)
			)

			GROUP BY
				COALESCE(
					NULLIF(LTRIM(RTRIM(MainGroupingDesc)), ''),
					'Unassigned'
				),
				COALESCE(
					NULLIF(LTRIM(RTRIM(CustomerName)), ''),
					'Unknown Customer'
				)
			--filter out zero-value groups
			HAVING
				SUM(ISNULL(TotalLines, 0) + ISNULL(TotalTax, 0)) <> 0

				--sort the result
			ORDER BY
				SalesPerson,
				CustomerName;
		END;
		GO