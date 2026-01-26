USE northwind;
SELECT * FROM products;
SELECT id, product_name, list_price FROM products;

SELECT id, first_name, last_name, email_address FROM shippers;

SELECT first_name, last_name, city FROM customers;

SELECT * FROM order_details;

SELECT * FROM order_details WHERE unit_price > 10;
SELECT * FROM order_details WHERE unit_price <= 30;
SELECT * FROM order_details WHERE status_id = 1;
SELECT * FROM order_details WHERE unit_price >= 10 AND unit_price <= 20;
SELECT * FROM order_details WHERE unit_price BETWEEN 10 AND 20;
SELECT * FROM order_details WHERE unit_price >= 30 AND status_id = 1;
SELECT * FROM order_details WHERE unit_price >= 30 AND quantity <= 3;
SELECT * FROM order_details WHERE status_id = 0 OR status_id = 1; 
SELECT * FROM order_details WHERE unit_price >= 30 AND (status_id = 0 OR status_id = 1); 
SELECT * FROM order_details WHERE purchase_order_id IS NULL;
SELECT * FROM order_details WHERE purchase_order_id IS NOT NULL;
SELECT * FROM order_details WHERE inventory_id IS NULL;
SELECT * FROM order_details WHERE inventory_id IS NOT NULL;

SELECT ship_name, ship_country_region, ship_city, ship_address, ship_zip_postal_code FROM orders WHERE id = 41 OR id = 44 OR id = 80;

SELECT * FROM products;

SELECT * FROM products WHERE product_code = "NWTB-1";
SELECT * FROM products WHERE product_code = 'NWTB-1' OR product_code = 'NWTCO-3' OR product_code = 'NWTO-5';
SELECT * FROM products WHERE product_code IN ('NWTB-1', 'NWTCO-3', 'NWTO-5');
SELECT * FROM products WHERE minimum_reorder_quantity IN (5, 10);



SELECT * FROM medical_healthcare.Doctors;
SELECT * FROM medical_healthcare.Doctors WHERE email LIKE '%@example.com';
SELECT * FROM medical_healthcare.Doctors WHERE phone LIKE '001%';
SELECT * FROM medical_healthcare.Doctors WHERE phone LIKE '__________';
SELECT * FROM medical_healthcare.Doctors WHERE first_name LIKE '_e%';
