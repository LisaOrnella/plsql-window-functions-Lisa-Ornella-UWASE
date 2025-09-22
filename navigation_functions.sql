-- 1. LAG(): Month-over-month sales comparison (FIXED)
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(amount) AS current_month_sales,
    LAG(SUM(amount), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) AS previous_month_sales,
    ROUND(
        ((SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))) / 
        LAG(SUM(amount), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))) * 100, 2
    ) AS growth_percentage
FROM transactions
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;

-- 2. LEAD(): Next month sales forecast (FIXED)
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(amount) AS current_sales,
    LEAD(SUM(amount), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) AS next_month_forecast,
    ROUND(
        ((LEAD(SUM(amount), 1) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) - SUM(amount)) / 
        SUM(amount)) * 100, 2
    ) AS expected_growth
FROM transactions
GROUP BY DATE_FORMAT(sale_