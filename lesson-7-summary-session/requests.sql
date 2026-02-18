USE northwind;

SELECT orders.id AS order_id, order_date,
employees.first_name AS employees_first_name,
employees.last_name AS employees_last_name,
customers.first_name AS customers_first_name,
customers.last_name AS customers_last_name
FROM orders
LEFT JOIN employees ON orders.employee_id = employees.id
LEFT JOIN customers ON orders.customer_id = customers.id;
-- GET site.com/api/orders
-- SELECT * FROM orders;
SELECT o.id AS order_id, order_date,
e.first_name AS employees_first_name,
e.last_name AS employees_last_name,
c.first_name AS customers_first_name,
c.last_name AS customers_last_name
FROM orders AS o
LEFT JOIN employees AS e ON o.employee_id = e.id
LEFT JOIN customers AS c ON o.customer_id = c.id;