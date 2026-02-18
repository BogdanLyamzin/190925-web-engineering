USE northwind;

-- Выбрать все заказы, сделанные покупателем из Лос Анджелеса
SELECT * FROM orders WHERE customer_id 
IN (SELECT id FROM customers WHERE city = 'Los Angelas');

-- Выбрать из order_details те позиции где unit_price выше среднего
SELECT * FROM order_details 
WHERE unit_price > (SELECT AVG(unit_price) FROM order_details) 
ORDER BY unit_price ASC;

-- выбрать все заказы, оформленные Sales Manager
SELECT * FROM orders 
WHERE employee_id IN (SELECT id FROM employees WHERE job_title = 'Sales Manager');

-- Найти 10 продуктов, которые были заказаны чаще всего и узнать общую сумму заказов по ним
-- Продукты с наибольшим количеством заказов и суммарную стоимость
SELECT * FROM order_details;
-- product_id, product_name, total_orders, total_sum
-- Найти общее число заказов каждого товара
SELECT product_id, COUNT(product_id) AS total_orders 
FROM order_details GROUP BY product_id ORDER BY total_orders; 
-- Найти общее число заказов каждого товара и сумму каждого товара
SELECT product_id, COUNT(product_id) AS total_orders,
SUM(quantity * unit_price) AS total_sum
FROM order_details GROUP BY product_id ORDER BY total_sum ASC; 

SELECT product_id, product_name, total_orders, total_quantity, total_sum
FROM (SELECT product_id, COUNT(product_id) AS total_orders,
SUM(quantity) AS total_quantity,
SUM(quantity * unit_price) AS total_sum
FROM order_details GROUP BY product_id ORDER BY total_sum ASC) AS product_summary
JOIN products ON product_summary.product_id = products.id 
ORDER BY total_orders DESC;

WITH LA_customers AS (SELECT id FROM customers WHERE city = 'Los Angelas')
SELECT * FROM orders WHERE customer_id IN (SELECT id FROM LA_customers);

WITH avg_price AS (SELECT AVG(unit_price) as ap FROM order_details)
SELECT * FROM order_details 
WHERE unit_price > (SELECT ap FROM avg_price)
ORDER BY unit_price ASC;

WITH product_summary AS (SELECT product_id, COUNT(product_id) AS total_orders,
SUM(quantity) AS total_quantity,
SUM(quantity * unit_price) AS total_sum
FROM order_details GROUP BY product_id ORDER BY total_sum ASC)
SELECT product_id, product_name, total_orders, total_quantity, total_sum
FROM product_summary
JOIN products ON product_summary.product_id = products.id 
ORDER BY total_orders DESC;


