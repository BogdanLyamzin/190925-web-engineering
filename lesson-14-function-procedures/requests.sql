USE 190925_teacher;

CREATE FUNCTION is_large_order(amount DECIMAL(10,2))
RETURNS BOOLEAN
DETERMINISTIC
RETURN amount > 300;

SELECT *,
CASE WHEN amount > 300 THEN true ELSE false END is_large_order
 FROM orders;
 
 SELECT *, is_large_order(amount) AS large_order FROM orders;
 
 SELECT *,
 CASE WHEN YEAR(created_at) >= '2024' THEN true ELSE FALSE
 END new_user FROM users;
 
  SELECT *,
 CASE WHEN LEFT(created_at, 4) >= '2024' THEN true ELSE FALSE
 END new_user FROM users;
 
SELECT *,
 CASE WHEN SUBSTRING(created_at, 1, 4) >= '2024' THEN true ELSE FALSE
 END new_user FROM users;
 
CREATE FUNCTION is_new_user(c_date DATE)
RETURNS BOOLEAN
DETERMINISTIC
RETURN YEAR(c_date) >= '2024';

SELECT *, is_new_user(created_at) AS new_user FROM users;

DELIMITER //
CREATE FUNCTION get_order_category(amount DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(20);
    IF(amount > 400) THEN
		SET result = 'large';
	ELSEIF(amount > 200) THEN
		SET result = 'medium';
	ELSE
		SET result = 'small';
	END IF;
    RETURN result;
END //
DELIMITER ;

SELECT *, get_order_category(amount) AS order_category 
FROM orders;

DELIMITER //
CREATE FUNCTION get_shipping_cost(amount DECIMAL(10,2), channel VARCHAR(20))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE cost DECIMAL(10,2);
    
    IF channel = 'web' THEN
		SET cost = amount * 0.1;
	ELSEIF channel = 'mobile' THEN
		SET cost = amount * 0.07;
	ELSE 
		SET cost = amount * 0.04;
	END IF;
    
    RETURN cost;
END //
DELIMITER ;

SELECT *, get_shipping_cost(amount, channel) AS shipping_cost 
FROM orders;

SELECT users.id, users.city, users.status, 
COUNT(orders.id) AS total_orders
FROM users 
JOIN orders ON users.id = orders.user_id
GROUP BY orders.user_id ORDER BY total_orders;

DELIMITER //
CREATE FUNCTION calc_user_orders_count(uid INT)
RETURNS INT
BEGIN
	DECLARE total INT;
    SELECT COUNT(*) INTO total FROM orders WHERE user_id = uid;
    RETURN total;
END //
DELIMITER ;

SELECT id, city, status, calc_user_orders_count(id) AS total_orders
FROM users ORDER BY total_orders;

DROP FUNCTION calc_user_registered_years;
CREATE FUNCTION calc_user_registered_years(created_at DATE)
RETURNS INT
NOT DETERMINISTIC
RETURN YEAR(CURDATE()) - YEAR(created_at);

SELECT id, city, status,
calc_user_registered_years(created_at) AS registered_years
FROM users;

SELECT id, city, status, calc_user_orders_count(id) AS total_orders
FROM users WHERE id = 1;

DELIMITER //
CREATE PROCEDURE get_user_orders(IN uid INT)
BEGIN
	SELECT id, city, status, calc_user_orders_count(id) 
    AS total_orders
	FROM users WHERE id = uid;
END //
DELIMITER ;

CALL get_user_orders(5);

DELIMITER //
CREATE PROCEDURE create_order(IN uid INT, IN amount DECIMAL(10,2), IN channel VARCHAR(20))
BEGIN 
	INSERT INTO orders(user_id, order_date, amount, channel)
	VALUES(uid, CURDATE(), amount, channel);
END //
DELIMITER ;

CALL create_order(5, 199.99, 'web');

SELECT * FROM orders WHERE user_id = 5;