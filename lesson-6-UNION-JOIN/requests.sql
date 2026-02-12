use northwind;

SELECT first_name FROM customers
UNION ALL
SELECT first_name FROM employees;

SELECT first_name FROM customers
UNION
SELECT first_name FROM employees;

SELECT first_name, last_name FROM customers
UNION ALL
SELECT first_name, last_name FROM employees;

SELECT first_name, last_name FROM customers
UNION
SELECT first_name, last_name FROM employees;

SELECT first_name, last_name, job_title FROM customers
UNION
SELECT first_name, last_name, job_title, is_manager FROM employees;

SELECT first_name, last_name, 'customer' AS status FROM customers;

SELECT first_name, last_name, 'customer' AS status FROM customers WHERE city = 'Seattle'
UNION ALL
SELECT first_name, last_name, 'employee' AS status FROM employees WHERE city = 'Seattle';

SELECT *, status_name FROM orders JOIN orders_status ON orders.status_id = orders_status.id;

SELECT *, company FROM orders JOIN shippers ON orders.shipper_id = shippers.id;

SELECT *, company FROM orders LEFT JOIN shippers ON orders.shipper_id = shippers.id;

SELECT *, company FROM orders RIGHT JOIN shippers ON orders.shipper_id = shippers.id;

SELECT * FROM employees JOIN employee_privileges;

SELECT * FROM employees JOIN employee_privileges ON employees.id = employee_privileges.employee_id;

SELECT * FROM employees AS emp LEFT JOIN employee_privileges AS prv ON emp.id = prv.employee_id;

SELECT order_details.id, product_name FROM order_details JOIN products ON order_details.product_id = products.id;

SELECT order_details.id AS order_details_id, product_name FROM order_details JOIN products 
ON order_details.product_id = products.id;

SELECT od.id, product_name FROM order_details AS od JOIN products AS p
ON od.product_id = p.id;

SELECT od.id AS order_details_id, p.id AS product_id, product_name FROM order_details AS od JOIN products AS p
ON od.product_id = p.id;


















