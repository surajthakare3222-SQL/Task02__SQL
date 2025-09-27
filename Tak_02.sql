CREATE DATABASE SalesDB;
USE SalesDB;
-- Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);
-- Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE NOT NULL,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Customers
INSERT INTO customers (customer_name) VALUES
('Aarav'),
('Priya'),
('Rohan'),
('Neha'),
('Vikram');

-- Insert Products 
INSERT INTO products (product_name, price) VALUES
('Smartphone', 18000),
('Laptop', 55000),
('Earbuds', 2500),
('Bluetooth Speaker', 4000),
('Wrist Watch', 3000);

-- Insert Sales Data
INSERT INTO sales (sale_date, customer_id, product_id, quantity, total_amount) VALUES
('2025-08-01', 1, 2, 1, 55000),    -- Aarav bought 1 Laptop
('2025-08-01', 2, 1, 2, 36000),    -- Priya bought 2 Smartphones
('2025-08-02', 3, 3, 3, 7500),     -- Rohan bought 3 Earbuds
('2025-08-02', 4, 4, 1, 4000),     -- Neha bought 1 Bluetooth Speaker
('2025-08-03', 5, 5, 2, 6000),     -- Vikram bought 2 Watches
('2025-08-03', 1, 1, 1, 18000),    -- Aarav bought 1 Smartphone
('2025-08-04', 2, 2, 1, 55000),    -- Priya bought 1 Laptop
('2025-08-04', 3, 5, 1, 3000);     -- Rohan bought 1 Watch

-- 1. Daily Sales Totals
SELECT 
    sale_date,
    SUM(total_amount) AS daily_total
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 2. Average Transaction Value (per day)
SELECT 
    sale_date,
    ROUND(AVG(total_amount), 2) AS avg_transaction
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 3. Top 3 Products by Revenue
SELECT 
    p.product_name,
    SUM(s.total_amount) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 3;

-- 4. Customer-wise Total Spending
SELECT 
    c.customer_name,
    SUM(s.total_amount) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- 5. Number of Transactions Per Day
SELECT 
    sale_date,
    COUNT(sale_id) AS total_transactions
FROM sales
GROUP BY sale_date
ORDER BY sale_date;
-- 6. Product Sales Trend (Daily Breakdown)
SELECT 
    sale_date,
    p.product_name,
    SUM(s.quantity) AS daily_quantity,
    SUM(s.total_amount) AS daily_sales
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY sale_date, p.product_name
ORDER BY sale_date, daily_sales DESC;

