USE northwind;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price FROM products;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price, 
CASE WHEN standard_cost  >= 20 THEN "expensive" 
WHEN standard_cost >= 10 THEN "medium"  
WHEN standard_cost < 10 THEN "cheap"
END AS price_category 
FROM products;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price, 
CASE WHEN standard_cost  >= 20 THEN "expensive" 
WHEN standard_cost >= 10 THEN "medium"  
END AS price_category 
FROM products;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price, 
CASE WHEN standard_cost  >= 20 THEN "expensive" 
WHEN standard_cost >= 10 THEN "medium"  
ELSE "cheap"
END AS price_category 
FROM products;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price, 
CASE WHEN standard_cost  >= 20 THEN "expensive" 
WHEN standard_cost >= 10 THEN "medium"  
WHEN standard_cost IS NULL THEN "unknown"
ELSE "cheap"
END AS price_category 
FROM products;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price, 
IF (minimum_reorder_quantity > 10, 'large', 'normal') AS reorder_category
FROM products;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price, 
IF (minimum_reorder_quantity > 10, 'large', 'normal') AS reorder_category
FROM products WHERE minimum_reorder_quantity IS NOT NULL;

SELECT product_id, unit_price, quantity, 
(unit_price * quantity) AS total_price_without_discount, 
(unit_price * quantity * (1 - discount)) AS total_price 
FROM order_details;

SELECT company, LEFT(business_phone, 5) AS phone_code FROM customers;

SELECT company, SUBSTRING(business_phone, 6) AS phone_without_code FROM customers;

SELECT company, CONCAT(first_name, ' ', last_name) AS full_name FROM customers;

SELECT *, IF(notes IS NULL, 'not filled', notes) AS notes_normalized FROM employees;

SELECT *, COALESCE(notes, 'not filled') AS notes_normalized FROM employees;

SELECT *, COALESCE(notes, 'not filled') AS notes_normalized FROM employees;

SELECT UPPER(company) AS company, LOWER(first_name) as first_name, last_name FROM employees 
WHERE company = 'northwind traders';

SELECT company, first_name, last_name FROM employees WHERE LOWER(company) = 'northwind traders';

SELECT product_name AS name, standard_cost AS cost FROM products 
WHERE minimum_reorder_quantity IS NOT NULL 
ORDER BY standard_cost ASC;

SELECT product_name AS name, standard_cost AS cost FROM products 
WHERE minimum_reorder_quantity IS NOT NULL 
ORDER BY standard_cost DESC;

SELECT product_name AS name, standard_cost AS cost FROM products 
WHERE minimum_reorder_quantity IS NOT NULL 
ORDER BY standard_cost ASC, list_price DESC;

SELECT company, country_region, city FROM customers ORDER BY city ASC, company DESC;

SELECT id, ship_city, order_date FROM orders ORDER BY order_date ASC;

SELECT id, ship_city, shipped_date FROM orders ORDER BY shipped_date ASC;

SELECT id, ship_city, shipped_date FROM orders ORDER BY shipped_date DESC;

SELECT id, ship_city, shipped_date FROM orders WHERE shipped_date IS NOT NULL ORDER BY shipped_date DESC;

SELECT id, ship_city, shipped_date FROM orders WHERE shipped_date IS NULL;

SELECT id, ship_city, ship_address, ship_name, order_date FROM orders 
WHERE paid_date IS NULL 
ORDER BY order_date ASC;

SELECT id, (unit_price * quantity * (1 - discount)) AS total_price FROM order_details;

SELECT id, (unit_price * quantity * (1 - discount)) AS total_price FROM order_details 
ORDER BY (unit_price * quantity * (1 - discount)) ASC;

SELECT id, (unit_price * quantity * (1 - discount)) AS total_price FROM order_details 
ORDER BY total_price ASC;

SELECT id, (unit_price * quantity * (1 - discount)) AS total_price FROM order_details
ORDER BY total_price DESC LIMIT 10;

SELECT id, ship_name, ship_address, order_date FROM orders 
ORDER BY order_date DESC LIMIT 10;

SELECT id, product_name  AS name, standard_cost AS cost FROM products ORDER BY standard_cost DESC LIMIT 10;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price FROM products 
ORDER BY standard_cost DESC, list_price DESC LIMIT 10;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price FROM products 
ORDER BY standard_cost DESC, list_price DESC LIMIT 20;

SELECT id, product_name AS name, standard_cost AS cost, list_price AS price FROM products 
ORDER BY standard_cost DESC, list_price DESC LIMIT 10 OFFSET 20;

SELECT id, first_name, last_name, city FROM customers ORDER BY city ASC;

SELECT DISTINCT city from customers ORDER BY city ASC;

SELECT ship_name FROM orders ORDER BY ship_name ASC;

SELECT DISTINCT ship_name FROM orders ORDER BY ship_name ASC;



