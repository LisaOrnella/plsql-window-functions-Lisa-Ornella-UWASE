# Window Function Assignment -Clothing & Accessories Store Analysis

**Course:** Database Development with PL/SQL

**ID:** 28753

**Names:** UWASE Lisa Ornella

**Instructor:** Eric Maniraguha

**Date:** September 2025


## BUSINESS PROBLEM

### Business Context

**Company type**: Clothing & accessories store

**Department**: Sales & Marketing

**Industry**:Online and physical stores

**Location:** Kigali,Musanze, Huye

**Data Challenge**:
The company has multiple stores in different districts, but it’s hard to see which products sell the most, which customers buy the most, 
and how sales change month to month. Management wants to use data to make marketing and sales decisions.

**Expected Outcome**:

-Find the top products in each district.

-Check monthly sales and growth.

-Group customers based on how much they spend.

-Suggest marketing actions to improve sales.

**5 measurable goals:**

Goal 1: Identify the 5 products with the highest sales in each district for every quarter--using RANK()

Goal 2: Calculate the total sales amount for each month and keep a cumulative running total--using SUM() OVER()

Goal 3: Measure the percentage change in total sales from the previous month to the current month.--using LAG()/LEAD()

Goal 4: Divide all customers into 4 groups based on total spending in the past 12 months (top 25%, next 25%, etc)--using NTILE(4)

Goal 5: Compute the average sales for each 3-month period to observe trends over time.--using AVG() OVER()

## Database Schema

### Tables Structure

**Table Names**
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/all%20tables.png?raw=true)

**Customer Table**
```sql
-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(50),
    signup_date DATE
);
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/customer.png?raw=true)

**Products Table**
```sql
-- 2. Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/products.png?raw=true)

**Transaction Table**
```sql
-- 3. Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    amount DECIMAL(10,2),
    store_location VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/transaction%20table.png?raw=true)

### ER Diagram

![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/ER%20DIAGRAM.png?raw=true)

**Table Counts**
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/count.png?raw=true)

**The structure of customer table**
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/desc%20customers.png?raw=true)

**The Structure of Transaction table**
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/desc%20transactions.png?raw=true)

## Window Functions Implementation

### 1. RANKING Functions

### Query 1: ROW_NUMBER() - Customer Transaction Sequence
```sql
-- 1. ROW_NUMBER(): Sequential numbering of transactions per customer
SELECT 
    c.name AS customer_name,
    t.sale_date,
    t.amount,
    ROW_NUMBER() OVER (PARTITION BY t.customer_id ORDER BY t.sale_date) AS transaction_number
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY c.name, t.sale_date;
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/row%20number.png?raw=true)
**This shows the order of each customer's purchases. I can see who shops most often. This helps me find our regular customers.**

### Query 2: RANK()-Top Products by Region
```sql
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
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/1-rank().png?raw=true)
**Some products sell better in different places. Jeans are popular in the city, but dresses sell more in other areas. We should stock what each area likes.**

### Query 3: DENSE_RANK()-Customer Spending
```sql
-- 3. DENSE_RANK(): Customer spending ranking
SELECT 
    c.name AS customer_name,
    SUM(t.amount) AS total_spent,
    DENSE_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS spending_rank
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.name
ORDER BY spending_rank;
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/1-dense%20rank().png?raw=true)
**This lists customers from biggest spenders to smallest. The top few customers bring us most of our money.
We should take good care of them**

**PERCENT_RANK()**
```sql
-- 4. PERCENT_RANK(): Product performance percentile
SELECT 
    p.name AS product_name,
    SUM(t.amount) AS total_revenue,
    ROUND(PERCENT_RANK() OVER (ORDER BY SUM(t.amount)) * 100, 2) AS percentile_rank
FROM transactions t
JOIN products p ON t.product_id = p.product_id
GROUP BY p.name
ORDER BY total_revenue DESC;
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/1-percent%20rank().png?raw=true)

**Some products make much more money than others. The handbag sells very well compared to other items. We should focus on what sells best.**

### AGGREGATE Functions

### Query 4: SUM() OVER()- Running Monthly Total
```sql
-- 1. SUM() OVER(): Running total of monthly sales (FIXED)
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(amount) AS monthly_sales,
    SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) AS running_total
FROM transactions
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/sum%20over.png?raw=true)
**Our sales keep growing each month.
The total money keeps getting bigger This means our business is doing well.**

### Query 5: AVG() OVER()-3-Month moving Average
```sql
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
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/avg()%20over().png?raw=true)

**This smooths out the ups and downs in sales. It shows our general growth pattern. It helps me predict future sales.**

**ROWS vs RANGE**
```sql
-- 3. ROWS vs RANGE comparison (FIXED)
SELECT 
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date ROWS UNBOUNDED PRECEDING) AS rows_running_total,
    SUM(amount) OVER (ORDER BY sale_date) AS range_running_total -- MySQL default is RANGE
FROM transactions
ORDER BY sale_date;
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/2%20row%20vs%20range.png?raw=true)
**Both ways of adding up sales give the same result here. This is because each day has different sales numbers. It's good to know they match.**

**MIN/MAX**
```sql
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
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/2%20min%20max.png?raw=true)
**Most products sell for about the same price each time. There aren't big price changes. This means our pricing is steady.**

### NAVIGATION Functions

### Query 6: LAG()-Month-over-Month Growth
```sql

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
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/lag.png?raw=true)
**Some months sales go up, some months they go down. February was better than January. I need to understand why sales change each month.**

### Query 7: LEAD()-Sales Forecasting
```sql
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
GROUP BY DATE_FORMAT(sale_date, '%Y-%m') ORDER BY sale_month;
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/LEAD.png?raw=true)
**This guesses what might happen next
month. It thinks sales will keep growing.
This helps me plan ahead.**

### DISTRIBUTION Functions
### Query 8: NTILE(4)- Customer Quartiles
```sql
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
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/5%20NTILE.png?raw=true)

**I put customers into four groups by how much they spend. The top group gives us most of our money. We should treat them specially.**

### Query 9: CUME_DIST()- Product Cumulative Distribution
```sql
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
```
![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/5%20CUME%20DIST.png?raw=true)

**Half of our products make most of our money. A few products are really important for our business. We should focus on those.**
# 📊 Results Analysis

### 🔹 Descriptive (What happened?)
- Jeans and shoes sold the most.  
- Sales went up in December because of holidays.  
- A few customers spent more money than most others.  

### 🔹 Diagnostic (Why did it happen?)
- Holiday discounts made December sales higher.  
- Kigali had more sales since it has more people.  
- Big customers bought often and spent a lot more.  

### 🔹 Prescriptive (What next?)
- Stock more jeans and shoes in Kigali and Musanze.  
- Give special offers or loyalty rewards to big customers.  
- Keep holiday promotions each December to boost sales.  

---

## SQL Files
- `creation.sql` - Database setup and sample data
- `ranking.sql` - Ranking functions implementation  
- `aggregate_functions.sql` - Aggregate functions with window frames
- `navigation_functions.sql` - Navigation functions for trend analysis
- `Distribution Functions.sql` - Distribution functions for segmentation
#  References
1. Oracle PL/SQL Documentation  
2. MySQL Window Functions Guide  
3. youtube Tutorials on Window Functions  
4. Chatgpt for personal assistance 
5. GeeksforGeeks SQL Analytical Functions  
6. Github  
7. Lecturer's notes  
8. DBMS notes  
9. youtube tutorials  
10. TutorialsPoint

---

# Integrity Statement
All sources were properly cited. Implementations and analysis represent **original work**.  
No AI-generated content was copied without attribution or adaptation.




