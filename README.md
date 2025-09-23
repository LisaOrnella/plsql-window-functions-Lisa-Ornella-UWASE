##clothing & accessories store

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

**customers table** - Stores customer information
- `customer_id` (INT, PRIMARY KEY) - Unique ID for each customer
- `name` (VARCHAR) - Customer's full name
- `region` (VARCHAR) - District where customer is located (Kigali, Musanze, Huye)
- `signup_date` (DATE) - When customer joined

**products table** - Stores product catalog
- `product_id` (INT, PRIMARY KEY) - Unique ID for each product
- `name` (VARCHAR) - Product name (Denim Jeans, Summer Dress, etc.)
- `category` (VARCHAR) - Product category (Clothing, Accessories, Footwear)
- `price` (DECIMAL) - Product price

**transactions table** - Stores sales records
- `transaction_id` (INT, PRIMARY KEY) - Unique ID for each sale
- `customer_id` (INT, FOREIGN KEY) - Links to customers table
- `product_id` (INT, FOREIGN KEY) - Links to products table
- `sale_date` (DATE) - Date of sale
- `quantity` (INT) - Number of items sold
- `amount` (DECIMAL) - Total sale amount
- `store_location` (VARCHAR) - Where sale happened

### ER Diagram

![image alt]()

