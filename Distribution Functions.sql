-- Customer quartiles
SELECT
    c.name AS customer_name,
    c.region,
    SUM(t.amount) AS total_spent,
    -- NTILE(4) divides the ordered customers into 4 equal groups (quartiles).
    -- It is ordered by total_spent DESC, so quartile 1 is the highest spending group.
    NTILE(4) OVER (ORDER BY SUM(t.amount) DESC) AS spending_quartile,
    -- A CASE statement is used to assign a descriptive segment name based on the quartile.
    CASE NTILE(4) OVER (ORDER BY SUM(t.amount) DESC)
        WHEN 1 THEN 'Platinum (Top 25%)'  -- Quartile 1: Highest Spenders
        WHEN 2 THEN 'Gold (25-50%)'       -- Quartile 2: Next Highest Spenders
        WHEN 3 THEN 'Silver (50-75%)'     -- Quartile 3: Mid-Range Spenders
        WHEN 4 THEN 'Bronze (75-100%)'    -- Quartile 4: Lowest Spenders
    END AS customer_segment
FROM
    transactions t
JOIN
    customers c ON t.customer_id = c.customer_id
-- Grouping by customer name and region is necessary to calculate the SUM(t.amount) per customer.
GROUP BY
    c.name, c.region
-- Orders the final result first by quartile (1 through 4) and then by total spent within each quartile.
ORDER BY
    spending_quartile, total_spent DESC;
    
    --cumulative distribution of product sales
SELECT
    p.name AS product_name,
    SUM(t.amount) AS total_sales,
    ROUND(CUME_DIST() OVER (ORDER BY SUM(t.amount) ASC) * 100, 2) AS cumulative_distribution_percent
FROM
    transactions t
JOIN
    products p ON t.product_id = p.product_id
GROUP BY
    p.name
ORDER BY
    total_sales DESC;