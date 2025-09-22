-- 1. ROW_NUMBER(): Sequential numbering of transactions per customer (FIXED)
SELECT 
    c.name AS customer_name,
    t.sale_date,
    t.amount,
    ROW_NUMBER() OVER (PARTITION BY t.customer_id ORDER BY t.sale_date) AS transaction_number
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY c.name, t.sale_date;

-- 2. RANK(): Top products by sales in each region
SELECT 
    c.region,
    p.name AS product_name,
    SUM(t.amount) AS total_sales,
    RANK() OVER (PARTITION BY c.region ORDER BY SUM(t.amount) DESC) AS sales_rank
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products p ON t.product_id = p.product_id
GROUP BY c.region, p.name
ORDER BY c.region, sales_rank;

-- 3. DENSE_RANK(): Customer spending ranking
SELECT 
    c.name AS customer_name,
    SUM(t.amount) AS total_spent,
    DENSE_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS spending_rank
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.name
ORDER BY spending_rank;

-- 4. PERCENT_RANK(): Product performance percentile
SELECT 
    p.name AS product_name,
    SUM(t.amount) AS total_revenue,
    ROUND(PERCENT_RANK() OVER (ORDER BY SUM(t.amount)) * 100, 2) AS percentile_rank
FROM transactions t
JOIN products p ON t.product_id = p.product_id
GROUP BY p.name
ORDER BY total_revenue DESC;
