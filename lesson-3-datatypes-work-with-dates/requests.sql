USE northwind;

SELECT (quantity * unit_price) AS total_price FROM order_details;
SELECT (quantity * unit_price) AS brutto_price, (quantity * unit_price * discount) AS netto_price FROM order_details;
SELECT (quantity * unit_price) - (quantity * unit_price * discount) AS dif_price FROM order_details;
SELECT (quantity * unit_price) AS euro_total_price, (quantity * unit_price / 0.8) AS usd_total_price FROM order_details;
SELECT (quantity * unit_price) AS euro_total_price, (quantity * unit_price / '0.8') AS usd_total_price FROM order_details;
SELECT (quantity * unit_price) AS euro_total_price, (quantity * unit_price / '0.8b') AS usd_total_price FROM order_details;
SELECT (quantity * unit_price) AS euro_total_price, (quantity * unit_price / 'b0.8') AS usd_total_price FROM order_details;
SELECT ('b' + 'dfsdgf') AS sum;
SELECT (1 + '2025-01-11') AS sum;

SELECT id, country_region, city, address, 
CONCAT(country_region, " ", city, ' ', address) AS full_address FROM customers;

SELECT id, product_name, standard_cost FROM products;
SELECT id, CONCAT(product_name, ' cost: ', standard_cost, ' at ', NOW()) as product_short_info FROM products;

SELECT id, SUBSTRING(invoice_date, 1, 7) AS invoice_month FROM invoices;

SELECT id, first_name, last_name, 
IF(is_manager = 1, 'manager', 'employee') AS role FROM employees;

SELECT id, first_name, last_name, 
CASE WHEN is_manager = 1 THEN 'manager' ELSE 'employee' END AS role FROM employees;

SELECT NOW();

SELECT CURDATE();

SELECT CURTIME();

SELECT DATE_FORMAT(NOW(), '%d-%m-%Y %H:%i:%s') AS formattedDate;

SELECT DATE_FORMAT('05-11-2026', '%d-%m-%Y') AS formattedDate;

SELECT DATE_FORMAT('2026-11-01', '%d-%m-%Y') AS formattedDate;

SELECT DATE_FORMAT('2026-11-01', '%d-%m-%Y %H:%i:%s') AS formattedDate;

SELECT DATEDIFF(NOW(), '2025-11-01') AS dateDiff;

SELECT DATEDIFF('2025-11-01 01:11:11', '2025-11-01 01:11:12') AS dateDiff;

SELECT TIMEDIFF('2025-12-01 01:11:11', '2025-11-01 01:11:12') AS dateDiff;

SELECT TIMESTAMPDIFF(HOUR, '2025-11-01', NOW()) AS date_diff;

SELECT DATE_ADD(NOW(), INTERVAL 10 DAY) as future_date;

SELECT DATE_ADD(NOW(), INTERVAL 10 HOUR) as future_date;

SELECT DATE_SUB(NOW(), INTERVAL 10 DAY) as past_date;

SELECT EXTRACT(DAY FROM NOW()) AS current_year;

SELECT TIME_TO_SEC(NOW()) AS seconds;

SELECT id, DATE_FORMAT(order_date, '%d-%m-%Y') as short_date FROM orders;
SELECT id, DATE_FORMAT(order_date, '%d/%m/%Y %H-%i-%s') as formatted_date FROM orders;

SELECT id, employee_id, customer_id, 
DATEDIFF(order_date, paid_date) as day_to_paid FROM orders 
WHERE paid_date IS NOT NULL ORDER BY day_to_paid DESC;

SELECT id, employee_id, ship_country_region, ship_city,
DATEDIFF(shipped_date, order_date) AS day_to_ship
FROM orders WHERE paid_date IS NOT NULL AND shipped_date IS NOT NULL
ORDER BY day_to_ship DESC;

SELECT id, employee_id, ship_country_region, ship_city,
DATEDIFF(shipped_date, order_date) AS day_to_ship
FROM orders 
WHERE paid_date IS NOT NULL AND shipped_date IS NOT NULL 
AND DATEDIFF(shipped_date, order_date) > 5
ORDER BY day_to_ship DESC;

SELECT id FROM orders 
WHERE order_date > DATE_SUB(NOW(), INTERVAL 5 DAY) 
ORDER BY order_date DESC;


