## clothing & accessories store

**Company type**: Clothing & accessories store

**Department**: Sales & Marketing

**Industry**:Online and physical stores

**Data Challenge**:
The company has multiple stores in different districts, but it’s hard to see which products sell the most, which customers buy the most, 
and how sales change month to month. Management wants to use data to make marketing and sales decisions.

**Expected Outcome**:

-Find the top products in each district.

-Check monthly sales and growth.

-Group customers based on how much they spend.

-Suggest marketing actions to improve sales.

**5 measurable goals:**

Goal 1: Identify the 5 products with the highest sales in each district for every quarter

Goal 2: Calculate the total sales amount for each month and keep a cumulative running total

Goal 3: Measure the percentage change in total sales from the previous month to the current month.

Goal 4: Divide all customers into 4 groups based on total spending in the past 12 months (top 25%, next 25%, etc)

Goal 5: Compute the average sales for each 3-month period to observe trends over time.

## Database Schema

### Tables Structure
```sql
-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(50),
    signup_date DATE
);

-- 2. Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

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

### ER Diagram

![image alt](https://github.com/LisaOrnella/plsql-window-functions-Lisa-Ornella-UWASE/blob/main/ER%20DIAGRAM.png?raw=true)

## RANKING

**ROW_NUMBER()**
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

**RANK()**
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

**DENSE_RANK()**
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
![image alt](<img width="1015" height="525" alt="image" src="https://github.com/user-attachments/assets/6843991a-531e-4dba-95e2-d2864d050f01" />)



