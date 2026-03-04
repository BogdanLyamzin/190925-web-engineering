USE 190925_teacher;

CREATE TABLE departments (
id INT PRIMARY KEY,
name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE employees (
	id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age TINYINT UNSIGNED NOT NULL ,
    salary INT UNSIGNED NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

SELECT * FROM employees WHERE id = 100;

EXPLAIN SELECT * FROM employees WHERE id = 100;

EXPLAIN ANALYZE SELECT * FROM employees WHERE id = 100;
/*
-> Rows fetched before execution  (cost=0..0 rows=1) 
(actual time=74e-6..115e-6 rows=1 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM employees WHERE full_name = 'Employee_00150';
/*
'-> Filter: (employees.full_name = \'Employee_00150\')  (cost=77 rows=76) 
(actual time=0.14..0.506 rows=1 loops=1)\n    
-> Table scan on employees  (cost=77 rows=760) 
(actual time=0.0594..0.329 rows=760 loops=1)\n'

*/
 
 EXPLAIN ANALYZE SELECT * FROM employees WHERE salary = 128777;
 /*
 -> Filter: (employees.salary = 128777)  
 (cost=99.5 rows=98.3) (actual time=0.388..0.481 rows=1 loops=1)
     -> Table scan on employees  
     (cost=99.5 rows=983) 
     (actual time=0.0617..0.407 rows=983 loops=1)
 */

CREATE INDEX idx_employees_sallary ON employees(salary);

 EXPLAIN ANALYZE SELECT * FROM employees WHERE salary = 128777;
 /*
 -> Index lookup on employees using idx_employees_sallary (salary=128777)  
 (cost=0.35 rows=1) (actual time=0.0251..0.0267 rows=1 loops=1)
 */
 
  EXPLAIN ANALYZE SELECT * FROM employees 
  WHERE salary = 128777 AND full_name = 'Employee_00500';
  /*
  -> Filter: (employees.full_name = 'Employee_00500')  
  (cost=0.26 rows=0.1) (actual time=0.028..0.028 rows=0 loops=1)
     -> Index lookup on employees using idx_employees_sallary 
     (salary=128777)  (cost=0.26 rows=1) 
     (actual time=0.0232..0.0248 rows=1 loops=...
  */
 
EXPLAIN ANALYZE SELECT *, COUNT(*) as total_department_employees 
FROM employees 
GROUP BY department_id ORDER BY total_department_employees DESC;
/*
-> Sort: total_department_employees DESC  
(actual time=3.48..3.48 rows=10 loops=1)
     -> Stream results  (cost=406 rows=10) 
     (actual time=0.466..3.47 rows=10 loops=1)
         -> Group aggregate: count(0)  
         (cost=406 rows=10) (actual time=0.46..3.46 rows=1...
*/
CREATE INDEX idx_employees_department_id ON employees(department_id);

EXPLAIN ANALYZE SELECT *, COUNT(*) as total_department_employees 
FROM employees 
GROUP BY department_id ORDER BY total_department_employees DESC;
/*
-> Sort: total_department_employees DESC  
(actual time=3.3..3.3 rows=10 loops=1)
     -> Stream results  (cost=406 rows=10) 
     (actual time=0.409..3.29 rows=10 loops=1)
         -> Group aggregate: count(0)  
         (cost=406 rows=10) (actual time=0.405..3.28 rows=10...
*/

CREATE INDEX idx_employees_full_name ON employees(full_name);

EXPLAIN ANALYZE SELECT * FROM employees WHERE full_name = 'Employee_00150';
/*
-> Index lookup on employees using idx_employees_full_name 
(full_name='Employee_00150')  
(cost=0.35 rows=1) (actual time=0.0259..0.0277 rows=1 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM employees WHERE LOWER(full_name) = 'employee_00150';
/*
-> Filter: (lower(employees.full_name) = 'employee_00150')  
(cost=204 rows=2018) (actual time=0.165..1.43 rows=1 loops=1)
     -> Table scan on employees  
     (cost=204 rows=2018) (actual time=0.0924..0.798 rows=2018 loops=1)
 */
 CREATE INDEX idx_employees_full_name_lower_case ON employees((LOWER(full_name)));
 
 EXPLAIN ANALYZE SELECT * FROM employees 
 WHERE LOWER(full_name) = 'employee_00150';
 /*
 -> Index lookup on employees using idx_employees_full_name_lower_case 
 (lower(full_name)='employee_00150')  
 (cost=0.35 rows=1) 
 (actual time=0.032..0.034 rows=1 loops=1)
 */

 EXPLAIN ANALYZE SELECT * FROM employees 
 WHERE department_id = 5 AND salary = 10000;
 /*
 -> Filter: (employees.department_id = 5)  (cost=0.26 rows=0.1) 
 (actual time=0.0144..0.0144 rows=0 loops=1)
     -> Index lookup on employees using idx_employees_sallary (salary=10000)  (cost=0.26 rows=1) (actual time=0.0138..0.0138 rows=0 loops=1)
 */
 
 CREATE INDEX idx_employees_department_id_salary 
 ON employees(department_id, salary);
 
EXPLAIN ANALYZE SELECT * FROM employees 
 WHERE department_id = 5 AND salary = 10000;
 /*
 -> Filter: (employees.department_id = 5)  
 (cost=0.26 rows=0.1) (actual time=0.0162..0.0162 rows=0 loops=1)
     -> Index lookup on employees using idx_employees_sallary (salary=10000)  
     (cost=0.26 rows=1) (actual time=0.0156..0.0156 rows=0 loops=1)
 */
 
 
 
 
 
 