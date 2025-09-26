CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    country VARCHAR(50),
    signup_date DATE
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);


--1. Select customer names and their countries
SELECT name, country
FROM customers
WHERE country = 'India'
ORDER BY name ASC;

-- 2. Total sales by category
SELECT p.category, SUM(oi.quantity * oi.price) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 3. INNER JOIN: Get all orders with customer names
SELECT o.order_id, c.name AS customer_name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.total_amount DESC;

-- 4. LEFT JOIN: Get all customers and their orders (if any)
SELECT c.name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 5.RIGHT JOIN (PostgreSQL only): Get all orders and their customers
SELECT o.order_id, c.name AS customer_name, o.total_amount
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id;


-- 6. Customers who spent more than average order amount
SELECT name, customer_id
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING AVG(total_amount) > (SELECT AVG(total_amount) FROM orders)
);


-- 7. Total revenue
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- 8. Average order amount per customer
SELECT customer_id, AVG(total_amount) AS avg_order_amount
FROM orders
GROUP BY customer_id;


--9. View for monthly sales
CREATE and replace VIEW monthly_sales1 AS
SELECT DATE_TRUNC('month', order_date) AS month, 
       SUM(total_amount) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- Index to speed up filtering by customer_id in orders
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- Index to speed up filtering by category in products
CREATE INDEX idx_products_category ON products(category);


