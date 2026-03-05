USE 190925_teacher;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  city VARCHAR(50),
  status VARCHAR(20),
  created_at DATE
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  order_date DATE,
  amount DECIMAL(10,2),
  channel VARCHAR(20),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE numbers (n INT PRIMARY KEY);

INSERT INTO numbers (n)
SELECT x.n
FROM (
  SELECT a.n + b.n*10 + c.n*100 + d.n*1000 + e.n*10000 + 1 AS n
  FROM (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1) e
) x
WHERE x.n <= 200000;

INSERT INTO users (city, status, created_at)
SELECT
    ELT(1 + FLOOR(RAND()*10),
        'Berlin','Munich','Hamburg','Cologne','Frankfurt',
        'Stuttgart','Dresden','Leipzig','Bremen','Dortmund') AS city,
    CASE
        WHEN RAND() < 0.80 THEN 'active'
        WHEN RAND() < 0.95 THEN 'trial'
        ELSE 'blocked'
    END AS status,
    DATE_ADD('2022-01-01', INTERVAL FLOOR(RAND()*900) DAY) AS created_at
FROM numbers;

CREATE TABLE numbers1m (n INT PRIMARY KEY);

INSERT INTO numbers1m (n)
SELECT x.n
FROM (
  SELECT a.n + b.n*10 + c.n*100 + d.n*1000 + e.n*10000 + f.n*100000 + 1 AS n
  FROM (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) e
  CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) f
) x
WHERE x.n <= 1000000;

SET @max_user_id := (SELECT MAX(id) FROM users);

INSERT INTO orders (user_id, order_date, amount, channel)
SELECT
    1 + FLOOR(RAND()*@max_user_id) AS user_id,
    DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*730) DAY) AS order_date,
    ROUND(10 + RAND()*490, 2) AS amount,
    ELT(1 + FLOOR(RAND()*3), 'web','mobile','partner') AS channel
FROM numbers1m;

SELECT * FROM users WHERE city = 'Berlin';
SELECT COUNT(id) AS total_users_from_berlin FROM users WHERE city = 'Berlin';

EXPLAIN ANALYZE SELECT * FROM users WHERE city = 'Berlin';
/*
-> Filter: (users.city = 'Berlin')  
	(cost=1927 rows=1903) (actual time=0.149..74.3 rows=1984 loops=1)
     -> Table scan on users  (cost=1927 rows=19028) 
		 (actual time=0.144..72 rows=20000 loops=1)
        0.72 + 0.74 = 1.5
*/

CREATE INDEX idx_users_city ON users(city);
EXPLAIN ANALYZE SELECT * FROM users WHERE city = 'Berlin';
/*
-> Index lookup on users using idx_users_city (city='Berlin')  
	(cost=271 rows=1984) (actual time=0.446..4.07 rows=1984 loops=1)
	0,02
*/

SELECT city, COUNT(*) AS total_users FROM users 
WHERE status = 'active' GROUP BY city;

EXPLAIN ANALYZE SELECT city, COUNT(*) AS total_users FROM users 
WHERE status = 'active' GROUP BY city;
/*
-> Group aggregate: count(0)  
	(cost=2117 rows=10) (actual time=4.77..40.8 rows=10 loops=1)
     -> Filter: (users.`status` = 'active')  
		(cost=1927 rows=1903) (actual time=0.878..38 rows=16020 loops=1)
         -> Index scan on users using idx_users_city  (...
*/
CREATE INDEX idx_users_status_city ON users(status, city);

EXPLAIN ANALYZE SELECT city, COUNT(*) AS total_users FROM users 
WHERE status = 'active' GROUP BY city;
/*
-> Group aggregate: count(0)  
	(cost=2224 rows=10) (actual time=1.07..9.72 rows=10 loops=1)
     -> Covering index lookup on users using idx_users_status_city 
		(status='active')  (cost=1273 rows=9514) 
        (actual time=0.198..6.9 rows=16020 loops=1)
*/
EXPLAIN ANALYZE SELECT * FROM users WHERE status = 'trial';
/*
-> Index lookup on users using idx_users_status_city (status='trial')  
	(cost=452 rows=3790) (actual time=0.921..7.67 rows=3790 loops=1)
*/
DROP INDEX idx_users_city ON users;
EXPLAIN ANALYZE SELECT * FROM users WHERE city = 'Berlin';
/*
-> Filter: (users.city = 'Berlin')  
	(cost=1927 rows=1903) (actual time=0.209..9.5 rows=1984 loops=1)
     -> Table scan on users  
		(cost=1927 rows=19028) (actual time=0.204..7.54 rows=20000 loops=1)
*/
SELECT orders.id, orders.amount, users.city
FROM orders
JOIN users ON orders.user_id = users.id
WHERE city = 'Berlin';

EXPLAIN ANALYZE SELECT orders.id, orders.amount, users.city
FROM orders
JOIN users ON orders.user_id = users.id
WHERE city = 'Berlin';
/*
-> Nested loop inner join  
(cost=38250 rows=103780) (actual time=0.369..374 rows=98865 loops=1)
     -> Filter: (users.city = 'Berlin')  
		(cost=1927 rows=1903) (actual time=0.136..8.02 rows=1984 loops=1)
         -> Covering index scan on users using idx_us...
*/

CREATE INDEX idx_users_city ON users(city);
CREATE INDEX idx_orders_user_id ON orders(user_id);

EXPLAIN ANALYZE SELECT orders.id, orders.amount, users.city
FROM orders
JOIN users ON orders.user_id = users.id
WHERE city = 'Berlin';
/*
-> Nested loop inner join  
(cost=35300 rows=100150) (actual time=0.336..866 rows=98865 loops=1)
     -> Covering index lookup on users using idx_users_city (city='Berlin')  
     (cost=247 rows=1984) (actual time=0.0936..1.41 rows=1984 loops=1)
     -> Index loo...
*/


