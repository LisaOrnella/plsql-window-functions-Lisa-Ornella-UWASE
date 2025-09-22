-- Insert into Customers
INSERT INTO customers VALUES (1, 'Alice Uwase', 'Kigali', DATE '2024-01-10');
INSERT INTO customers VALUES (2, 'Bob Mugisha', 'Kigali', DATE '2024-01-15');
INSERT INTO customers VALUES (3, 'Claire Imane', 'Musanze', DATE '2024-02-01');
INSERT INTO customers VALUES (4, 'David Habimana', 'Huye', DATE '2024-02-10');
INSERT INTO customers VALUES (5, 'Emma Uwimana', 'Kigali', DATE '2024-03-05');
INSERT INTO customers VALUES (6, 'Frank Kanane', 'Musanze', DATE '2024-03-12');
INSERT INTO customers VALUES (7, 'Grace Mukamana', 'Huye', DATE '2024-04-01');
INSERT INTO customers VALUES (8, 'Henry Twagiramungu', 'Kigali', DATE '2024-04-15');
INSERT INTO customers VALUES (9, 'Irene Mutoni', 'Musanze', DATE '2024-05-03');
INSERT INTO customers VALUES (10, 'James Nkusi', 'Huye', DATE '2024-05-20');

-- Insert into Products
INSERT INTO products VALUES (1, 'Casual T-Shirt', 'Clothing', 15000);
INSERT INTO products VALUES (2, 'Denim Jeans', 'Clothing', 35000);
INSERT INTO products VALUES (3, 'Summer Dress', 'Clothing', 45000);
INSERT INTO products VALUES (4, 'Leather Handbag', 'Accessories', 55000);
INSERT INTO products VALUES (5, 'Sports Shoes', 'Footwear', 40000);
INSERT INTO products VALUES (6, 'Sunglasses', 'Accessories', 25000);
INSERT INTO products VALUES (7, 'Winter Jacket', 'Clothing', 65000);
INSERT INTO products VALUES (8, 'Formal Shirt', 'Clothing', 30000);

-- Insert into Transactions (Spread across 6 months)
INSERT INTO transactions VALUES (1, 1, 1, DATE '2024-01-15', 2, 30000, 'Kigali City Mall');
INSERT INTO transactions VALUES (2, 2, 2, DATE '2024-01-20', 1, 35000, 'Kigali Downtown');
INSERT INTO transactions VALUES (3, 3, 3, DATE '2024-02-05', 1, 45000, 'Musanze Center');
INSERT INTO transactions VALUES (4, 1, 4, DATE '2024-02-10', 1, 55000, 'Kigali City Mall');
INSERT INTO transactions VALUES (5, 4, 5, DATE '2024-02-15', 1, 40000, 'Huye Plaza');
INSERT INTO transactions VALUES (6, 2, 6, DATE '2024-03-01', 2, 50000, 'Kigali Downtown');
INSERT INTO transactions VALUES (7, 5, 7, DATE '2024-03-10', 1, 65000, 'Kigali City Mall');
INSERT INTO transactions VALUES (8, 3, 1, DATE '2024-03-15', 3, 45000, 'Musanze Center');
INSERT INTO transactions VALUES (9, 6, 2, DATE '2024-04-05', 1, 35000, 'Musanze Center');
INSERT INTO transactions VALUES (10, 1, 3, DATE '2024-04-12', 1, 45000, 'Kigali City Mall');
INSERT INTO transactions VALUES (11, 7, 4, DATE '2024-04-20', 1, 55000, 'Huye Plaza');
INSERT INTO transactions VALUES (12, 4, 5, DATE '2024-05-01', 2, 80000, 'Huye Plaza');
INSERT INTO transactions VALUES (13, 8, 6, DATE '2024-05-10', 1, 25000, 'Kigali Downtown');
INSERT INTO transactions VALUES (14, 2, 7, DATE '2024-05-15', 1, 65000, 'Kigali Downtown');
INSERT INTO transactions VALUES (15, 9, 1, DATE '2024-06-05', 2, 30000, 'Musanze Center');
INSERT INTO transactions VALUES (16, 5, 2, DATE '2024-06-10', 1, 35000, 'Kigali City Mall');
INSERT INTO transactions VALUES (17, 10, 3, DATE '2024-06-15', 1, 45000, 'Huye Plaza');
INSERT INTO transactions VALUES (18, 1, 4, DATE '2024-06-20', 1, 55000, 'Kigali City Mall');
INSERT INTO transactions VALUES (19, 3, 5, DATE '2024-06-25', 1, 40000, 'Musanze Center');
INSERT INTO transactions VALUES (20, 7, 6, DATE '2024-06-30', 2, 50000, 'Huye Plaza');