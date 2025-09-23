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


