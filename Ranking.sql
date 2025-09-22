-- 1. Top Products by Region (Goal 1)
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

-- 2. Top Customers by Spending
SELECT 
    c.name,
    c.region,
    SUM(t.amount) AS total_spent,
    ROW_NUMBER() OVER (ORDER BY SUM(t.amount) DESC) AS customer_rank,
    DENSE_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS dense_customer_rank
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.name, c.region;

-- 3. Product Performance Percentile
SELECT 
    p.name,
    SUM(t.amount) AS total_revenue,
    PERCENT_RANK() OVER (ORDER BY SUM(t.amount)) AS percentile_rank
FROM transactions t
JOIN products p ON t.product_id = p.product_id
GROUP BY p.name;