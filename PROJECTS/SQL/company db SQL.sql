CREATE DATABASE company_db;
USE company_db;
CREATE TABLE departments (
     department_id   INT  PRIMARY KEY,
     department_name  VARCHAR(50) NOT NULL,
     location         VARCHAR(50)
);

CREATE TABLE employees (
     employee_id   INT PRIMARY KEY,
     first_name   VARCHAR(50),
     last_name   VARCHAR(50),
     email    VARCHAR(100),
     hire_date   DATE,
     salary   DECIMAL(10,2),
     department_id  INT,
     manager_id  INT,
     FOREIGN KEY  (department_id)  REFERENCES departments(department_id)
);     

CREATE TABLE sales(
    sale_id  INT PRIMARY KEY,
    employee_id  INT,
    sale_date   DATE,
    product_name  VARCHAR(50),
    amount   DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO departments VALUES
(1, 'Sales', 'Bengaluru'),
(2, 'Marketing', 'Mumbai'),
(3, 'IT', 'Hyderabad'),
(4, 'HR', 'Chennai');

INSERT INTO employees VALUES
(101, 'Anil', 'Kumar', 'anil.kumar@corp.com', '2019-03-14', 55000, 1, NULL),
(102, 'Divya', 'Rao', 'divya.rao@corp.com', '2020-07-01', 55000, 1, 101),
(103, 'Rahul', 'Shah', 'rahul.shah@corp.com', '2018-01-22', 62000, 2, NULL),
(104, 'Meera', 'Nair', 'meera.nair@corp.com', '2021-11-05', 45000, 2, 103),
(105, 'Sanjay', 'Verma', 'sanjay.verma@corp.com', '2022-05-19', 51000, 3, NULL),
(106, 'Priya', 'Iyer', NULL, '2023-02-10', 47000, 3, 105),
(107, 'Arun', 'Das', 'arun.das@corp.com', '2024-01-15', 40000, 1, NULL);

INSERT INTO sales VALUES
(1001, 101, '2024-01-05', 'Laptop', 75000.00),
(1002, 102, '2024-01-08', 'Mouse', 500.00),
(1003, 103, '2024-01-10', 'Tablet', 32000.00),
(1004, 104, '2024-01-12', 'Monitor', 12000.00),
(1005, 101, '2024-02-01', 'Laptop', 78000.00),
(1006, 105, '2024-02-03', 'Keyboard', 250000.00),
(1007, 106, '2024-02-14', 'Monitor', 11500.00),
(1008, 102, '2024-03-01', 'Laptop', 76000.00);

USE company_db;

# All columns
SELECT * FROM employees;

# Specific columns
SELECT first_name,last_name,salary FROM employees;

# Employees earning more than 50000
SELECT first_name,last_name,salary FROM employees WHERE salary > 50000;

# Employees in department 1, hired after 2019
SELECT * FROM employees WHERE department_id = 1 AND hire_date > '2019-12-31';

# Pattern match: names starting with 'A'
SELECT first_name,last_name FROM employees WHERE first_name LIKE 'A%';

# Pattern match: names stopping with 'A'
SELECT first_name,last_name FROM employees WHERE last_name LIKE '%A';

# Pattern match: names containing 'A'
SELECT first_name,last_name FROM employees WHERE first_name LIKE '%A%';

# Multiple allowed values
SELECT * FROM sales WHERE product_name IN ('Laptop' , 'Tablet');

# ORDER BY - Sorting results
# Highest paid employees first
SELECT first_name,last_name,salary FROM employees ORDER BY salary DESC;

# sort by department,then salary within department
SELECT department_id, first_name, salary FROM employees ORDER BY department_id ASC,salary DESC;

USE company_db;
# GROUP BY - aggregating rows :
# Total salary cost and headcount per department
SELECT department_id,COUNT(*) AS employee_count,SUM(salary) AS total_salary,AVG(salary) AS avg_salary FROM employees GROUP BY department_id;

# Total sales amount per product
SELECT product_name, SUM(amount) AS total_revenue FROM sales GROUP BY product_name ORDER BY total_revenue DESC;

# HAVING - filtering aggregated groups :
# Departments whose average salary exceeds 48000
SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING AVG(salary) > 48000;

# Products with total revenue above 20000
SELECT product_name, SUM(amount) AS total_revenue FROM sales GROUP BY product_name HAVING SUM(amount) > 20000;

# INNER,LEFT,RIGHT, and FULL JOIN :
# INNER JOIN :
SELECT e.first_name, e.last_name, d.department_name FROM employees e INNER JOIN departments d  ON e.department_id = d.department_id;

# LEFT JOIN :
# All employees, with their sale details if a sale exists.
SELECT e.first_name,e.last_name,s.sale_id FROM employees e left JOIN sales s ON  e.employee_id = s.employee_id;

# Find employees with no recorded sales at all
SELECT e.employee_id, e.first_name FROM employees e LEFT JOIN sales s  ON e.employee_id = s.employee_id WHERE s.sale_id IS NULL;

# RIGHT JOIN :
# All departments, even ones with no employees yet
SELECT e.first_name,d.department_name FROM employees e RIGHT JOIN  departments d  ON e.department_id = d.department_id;

# FULL JOIN :
SELECT e.first_name, e.salary,d.department_name, d.location
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id
UNION
SELECT e.first_name,e.salary, d.department_name,d.location
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

# SUB QUERIES :
# Scalar Subqueries :
# Show each employee's salary next to the company-wide average
SELECT first_name,salary,
  (SELECT AVG(salary) FROM employees ) AS company_avg_salary
FROM employees;

# Sub Query in WHERE :
# Employees who earn more than the average salary
SELECT first_name,last_name,salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

# Employees who have made at least one sale
SELECT first_name,last_name FROM employees WHERE employee_id IN (SELECT DISTINCT employee_id FROM sales);

# Correlated Subquery :
# Employees earning more than the average salary in their OWN department
SELECT e1.first_name,e1.department_id,e1.salary FROM employees e1 WHERE e1.salary > (SELECT AVG(e2.salary) FROM employees e2 WHERE e2.department_id = e1.department_id);

# Sub Query in FROM :
# Rank departments by total revenue using a derived table
SELECT dept_totals.department_id,dept_totals.total_revenue 
FROM (
   SELECT e.department_id,SUM(s.amount) AS total_revenue
   FROM employees e
   JOIN sales s ON e.employee_id = s.employee_id
   GROUP BY e.department_id
) AS dept_totals
ORDER BY dept_totals.total_revenue DESC;






