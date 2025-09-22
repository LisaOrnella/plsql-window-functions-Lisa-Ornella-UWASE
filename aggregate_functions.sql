-- 1. SUM() OVER(): Running total of monthly sales (FIXED)
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(amount) AS monthly_sales,
    SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) AS running_total
FROM transactions
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;

-- 2. AVG() OVER(): 3-month moving average (FIXED for MySQL)
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(amount) AS monthly_sales,
    ROUND(AVG(SUM(amount)) OVER (
        ORDER BY DATE_FORMAT(sale_date, '%Y-%m')
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_3month
FROM transactions
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;

-- 3. ROWS vs RANGE comparison (FIXED)
SELECT 
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date ROWS UNBOUNDED PRECEDING) AS rows_running_total,
    SUM(amount) OVER (ORDER BY sale_date) AS range_running_total -- MySQL default is RANGE
FROM transactions
ORDER BY sale_date;

-- 4. MIN/MAX with window frames
SELECT 
    p.name AS product_name,
    t.sale_date,
    t.amount,
    MIN(t.amount) OVER (PARTITION BY p.product_id) AS min_sale_amount,
    MAX(t.amount) OVER (PARTITION BY p.product_id) AS max_sale_amount
FROM transactions t
JOIN products p ON t.product_id = p.product_id
ORDER BY p.name, t.sale_date;