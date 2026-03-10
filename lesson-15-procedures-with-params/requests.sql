USE 190925_teacher;

DELIMITER //
CREATE PROCEDURE get_user_orders(IN uid INT)
BEGIN
	SELECT * FROM orders WHERE user_id = uid;
END //
DELIMITER ;

CALL get_user_orders(5);

DELIMITER //
CREATE PROCEDURE count_user_orders(IN uid INT, OUT total INT)
BEGIN
	SELECT COUNT(*) INTO total FROM orders WHERE user_id = uid;
END //
DELIMITER ;

SET @orders_count = 0;

CALL count_user_orders(5, @orders_count);

SELECT @orders_count;