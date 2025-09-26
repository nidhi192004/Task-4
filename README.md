Task 4: SQL for Data Analysis


Objective
The goal of this task was to use SQL queries to extract, manipulate, and analyze structured data from a relational database. The task covers advanced SQL concepts including joins, subqueries, aggregate functions, views, and query optimization.

Dataset Used
For this project, a sample Ecommerce database was created, containing the following tables:
Table	Description
customers -	Contains customer details
products - Contains product details
orders	- Contains order details linked to customers
order_items -	Contains details of ordered products
Tools Used


SQL — PostgreSQL / MySQL / SQLite

Database client (pgAdmin, MySQL Workbench, DBeaver, etc.)
Key SQL Concepts Applied
1. SELECT, WHERE, ORDER BY, GROUP BY
Used to retrieve specific data, filter it, sort it, and group data for analysis.
Example:

SELECT name, country
FROM customers
WHERE country = 'India'
ORDER BY name ASC;

2. JOINS (INNER, LEFT, RIGHT)
Used to combine data from multiple tables based on relationships.
Example:

SELECT o.order_id, c.name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

3. Subqueries
Used to perform nested queries for more complex data extraction.
Example:

SELECT name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING AVG(total_amount) > (SELECT AVG(total_amount) FROM orders)
);

4. Aggregate Functions (SUM, AVG)
Used to calculate totals, averages, and other summary statistics.
Example:

SELECT category, SUM(quantity * price) AS total_sales
FROM order_items
JOIN products ON order_items.product_id = products.product_id
GROUP BY category;

5. Views
Used to create reusable query results for analysis.
Example:

CREATE VIEW monthly_sales AS
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(total_amount) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

6. Index Optimization
Indexes were created to improve query performance.
Example:

CREATE INDEX idx_orders_customer_id ON orders(customer_id);


Deliverables
SQL queries file: Task4_SQL_DataAnalysis.sql
Screenshots of query outputs
README file (this file)


Outcome
By completing this task, I gained hands-on experience in:
Writing complex SQL queries
Performing data filtering, aggregation, and grouping
Using joins and subqueries effectively
Creating views for easier data access
Optimizing queries using indexes
