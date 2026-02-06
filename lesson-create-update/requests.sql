CREATE DATABASE 190925_teacher;

use 190925_teacher;

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birthdate DATE NOT NULL,
hiredate DATE DEFAULT(CURRENT_DATE) NOT NULL,
salary DECIMAL(10,2) CHECK (salary > 0),
email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO employees (first_name, last_name, birthdate, salary, email) 
VALUES ('Bohdan', 'Liamzin', '1986-01-03', 5000, 'bohdan@gmail.com');

INSERT INTO employees (first_name, last_name, birthdate, salary, email) 
VALUES ('Nastya', 'Kotova', '1995-07-12', 5000, 'kotova@gmail.com');

INSERT INTO employees (first_name, last_name, birthdate, hiredate, salary, email) 
VALUES ('Nastya', 'Ilchenko', '1998-05-22', '2024-12-12', 4000, 'ilchenko@gmail.com');

UPDATE employees SET salary = (salary + 200) WHERE id = 3;

UPDATE employees SET salary = salary * 1.1 WHERE hiredate < '2025-01-01' AND id >= 1;

SET SQL_SAFE_UPDATES = 0;

UPDATE employees SET salary = salary * 1.1 WHERE hiredate < '2025-01-01';

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM employees;

CREATE TABLE employees_short_info AS SELECT first_name, last_name, email FROM employees;

CREATE VIEW employees_info 
AS SELECT first_name, last_name, email, (salary * 12) AS salary_per_year 
FROM employees;

UPDATE employees SET salary = salary * 1.1 WHERE id >= 1;

