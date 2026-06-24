-- 1. Top 10 Funds by AUM

SELECT
scheme_name,
fund_house,
aum_crore
FROM fact_performance
ORDER BY aum_crore DESC
LIMIT 5;

-- 2. Average NAV by Month

SELECT
strftime('%Y-%m', date) AS month,
ROUND(AVG(nav),2) AS avg_nav
FROM fact_nav
GROUP BY month
ORDER BY month;

-- 3. Top 10 Funds by 1-Year Return

SELECT
scheme_name,
return_1yr_pct
FROM fact_performance
ORDER BY return_1yr_pct DESC
LIMIT 10;

-- 4. Transactions by State

SELECT
state,
COUNT(*) AS total_transactions,
ROUND(SUM(amount_inr),2) AS total_amount
FROM fact_transactions
GROUP BY state
ORDER BY total_amount DESC;

-- 5. Funds with Expense Ratio Below 1%

SELECT
scheme_name,
fund_house,
expense_ratio_pct
FROM fact_performance
WHERE expense_ratio_pct < 1
ORDER BY expense_ratio_pct;

-- 6. Top Sharpe Ratio Funds

SELECT
scheme_name,
sharpe_ratio
FROM fact_performance
ORDER BY sharpe_ratio DESC
LIMIT 10;

-- 7. Highest Alpha Funds

SELECT
scheme_name,
alpha
FROM fact_performance
ORDER BY alpha DESC
LIMIT 10;

-- 8. Transactions by Payment Mode

SELECT
payment_mode,
COUNT(*) AS total_transactions
FROM fact_transactions
GROUP BY payment_mode
ORDER BY total_transactions DESC;

-- 9. Average NAV by Fund

SELECT
amfi_code,
ROUND(AVG(nav),2) AS avg_nav
FROM fact_nav
GROUP BY amfi_code
ORDER BY avg_nav DESC;

-- 10. Fund Count by Fund House

SELECT
fund_house,
COUNT(*) AS total_funds
FROM fact_performance
GROUP BY fund_house
ORDER BY total_funds DESC;
