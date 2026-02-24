USE northwind;

SELECT supplier_ids, MAX(list_price) AS max_list_price FROM products
GROUP BY supplier_ids ORDER BY max_list_price DESC;

SELECT id, product_name, list_price, MAX(list_price) OVER()
AS max_list_price FROM products ORDER BY list_price ASC;

SELECT category, MAX(list_price) as max_list_price FROM products
GROUP BY category ORDER BY max_list_price DESC;

SELECT id, product_name, list_price, category, MAX(list_price) 
OVER(PARTITION BY category) AS max_list_price_this_category
FROM products ORDER BY list_price ASC;

SELECT id, product_name, list_price, AVG(list_price) OVER()
AS avg_list_price FROM products ORDER BY list_price ASC;

SELECT id, product_name, list_price, 
CASE WHEN list_price > AVG(list_price) OVER() THEN 'expensive'
ELSE 'cheap' END type
FROM products ORDER BY list_price ASC;

SELECT id, product_name, list_price 
FROM products WHERE list_price > (SELECT AVG(list_price) FROM products)
ORDER BY list_price ASC;

SELECT id, product_name, list_price, 
(list_price - AVG(list_price) OVER()) AS dif_between_avg_price 
FROM products ORDER BY dif_between_avg_price ASC;

