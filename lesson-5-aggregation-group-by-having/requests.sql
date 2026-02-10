use northwind;

SELECT * FROM orders WHERE ship_city = 'Las Vegas';

SELECT DISTINCT ship_name FROM orders WHERE ship_city = 'Las Vegas';

SELECT COUNT(DISTINCT ship_name) FROM orders WHERE ship_city = 'Las Vegas';

SELECT COUNT(*) AS total_customers FROM orders WHERE ship_city = 'Las Vegas';

SELECT COUNT(id) AS total_orders FROM orders; -- 48

SELECT COUNT(paid_date) AS total_paid_orders FROM orders; -- 38

SELECT COUNT(id) AS total_positions FROM order_details;

SELECT quantity, unit_price FROM order_details;

SELECT (quantity * unit_price) AS total_price FROM order_details ORDER BY total_price DESC;

SELECT SUM(quantity * unit_price * (1 - discount)) FROM order_details;
/*
SELECT quantity, unit_price FROM order_details;
SELECT (quantity * unit_price) AS total_price FROM order_details;
*/


SELECT AVG(quantity * unit_price) AS avg_total_price FROM order_details;

SELECT MIN(quantity * unit_price) AS min_total_price FROM order_details;

SELECT id, quantity, unit_price, (quantity * unit_price) AS total_price 
FROM order_details ORDER BY total_price ASC;

SELECT * FROM order_details WHERE id IN(90, 91);

SELECT DISTINCT ship_name FROM orders;

SELECT GROUP_CONCAT(DISTINCT ship_name) AS all_unique_names FROM orders;

SELECT DISTINCT city FROM employees;

SELECT COUNT(id) FROM employees; 

SELECT COUNT(id) FROM employees WHERE city = 'Seattle';

SELECT id, city FROM employees ORDER BY city ASC;

SELECT city FROM employees GROUP BY city; -- SELECT DISTINCT city FROM employees;

SELECT city, COUNT(id) as total_employees FROM employees GROUP BY city 
ORDER BY total_employees DESC;
SELECT city, COUNT(id) as total_employees FROM employees GROUP BY 1 ORDER BY 2;

SELECT city, COUNT(id) as total_employees FROM employees 
WHERE notes IS NOT NULL GROUP BY city;
/*
1. Выбрать всех людей по которым есть заметки:
SELECT id FROM employees WHERE notes IS NOT NULL;
2. Сгруппировать результат по городам:
SELECT id FROM employees WHERE notes IS NOT NULL ORDER BY city;
3. Посчитать количество записей в каждой  группе через id:
SELECT city, COUNT(id) as total_employees FROM employees 
WHERE notes IS NOT NULL GROUP BY city;
*/

SELECT order_id, COUNT(id) AS total_positions FROM order_details 
GROUP BY order_id ORDER BY total_positions DESC;

SELECT order_id, (quantity * unit_price) AS total_price FROM order_details;

SELECT order_id, SUM(quantity * unit_price) AS total_price FROM order_details 
WHERE quantity > 0 GROUP BY order_id ORDER BY total_price DESC;
/*
1. Находим все order_id где количество больше 0:
SELECT order_id FROM order_details WHERE quantity > 0;
2. Группируем по order_id (разделяем на подтаблицы по уникальному order_id):
SELECT order_id FROM order_details WHERE quantity > 0 GROUP BY order_id;
3. Умножаем по каждому подтаблице количество товара на цену единицы:
SELECT order_id, (quantity * unit_price) AS total_price 
FROM order_details WHERE quantity > 0 GROUP BY order_id;
4. Суммируем полученные столбцы total_price в каждой подтаблице:
SELECT order_id, SUM(quantity * unit_price) AS total_price 
FROM order_details WHERE quantity > 0 GROUP BY order_id;
5. Сортируем по total_price полученный результат:
SELECT order_id, SUM(quantity * unit_price) AS total_price FROM order_details 
WHERE quantity > 0 GROUP BY order_id ORDER BY total_price DESC;
*/

SELECT company, job_title, COUNT(id) as count_job_title FROM employees 
GROUP BY company, job_title ORDER BY count_job_title DESC;

SELECT order_id, SUM(quantity * unit_price) AS total_price FROM order_details 
WHERE quantity > 0 GROUP BY order_id HAVING total_price > 1000 ORDER BY total_price DESC;
/*
1. Находим все order_id где количество больше 0:
SELECT order_id FROM order_details WHERE quantity > 0;
2. Группируем по order_id (разделяем на подтаблицы по уникальному order_id):
SELECT order_id FROM order_details WHERE quantity > 0 GROUP BY order_id;
3. Умножаем по каждому подтаблице количество товара на цену единицы:
SELECT order_id, (quantity * unit_price) AS total_price 
FROM order_details WHERE quantity > 0 GROUP BY order_id;
4. Суммируем полученные столбцы total_price в каждой подтаблице:
SELECT order_id, SUM(quantity * unit_price) AS total_price 
FROM order_details WHERE quantity > 0 GROUP BY order_id;
5. Фильтруем полученный результат по total_price > 1000:
SELECT order_id, SUM(quantity * unit_price) AS total_price 
FROM order_details WHERE quantity > 0 GROUP BY order_id HAVING total_price > 1000;
6. Сортируем по total_price полученный результат:
SELECT order_id, SUM(quantity * unit_price) AS total_price FROM order_details 
WHERE quantity > 0 GROUP BY order_id ORDER BY total_price DESC;
*/

