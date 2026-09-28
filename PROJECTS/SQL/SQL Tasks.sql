USE company_db;
# SELECT :
# 1
SELECT * FROM employees;

# 2
SELECT first_name,last_name,email FROM employees;

# 3
SELECT employee_id,first_name,salary FROM employees;

# 4
SELECT first_name,hire_date,department_id FROM employees;

# 5
SELECT sale_id,employee_id,sale_date,amount FROM sales;

# 6
SELECT product_name,sale_date FROM sales;

# WHERE:
# 1
SELECT first_name,salary FROM employees WHERE salary < 50000;

# 2
SELECT first_name,department_id FROM employees WHERE department_id = 2;

# 3
SELECT first_name,hire_date FROM employees WHERE  hire_date < '2020-01-01';

# 4
SELECT first_name,salary FROM employees WHERE salary BETWEEN 45000 AND 60000;

# 5
SELECT first_name FROM employees WHERE first_name LIKE 'A%';

# 6
SELECT first_name FROM employees WHERE first_name LIKE '%a';

# 7
SELECT first_name FROM employees WHERE first_name LIKE '%i%';

# 8
SELECT product_name,amount FROM sales WHERE amount > 50000;

# 9
SELECT product_name,amount FROM sales WHERE amount BETWEEN 10000 AND 80000;

# 10
SELECT product_name FROM sales WHERE product_name != 'Laptop';

# 11
SELECT first_name,last_name,department_id FROM employees WHERE department_id =1 OR department_id = 3;

# ORDER BY :
# 1
USE company_db;
SELECT * FROM employees ORDER BY first_name ASC;

# 2
SELECT first_name,last_name,salary FROM employees ORDER BY salary ASC;

# 3
SELECT * FROM employees  ORDER BY hire_date DESC;

# 4
SELECT * FROM sales ORDER BY amount DESC;

# 5
SELECT * FROM employees ORDER BY department_id ASC ,salary DESC;

# 6
SELECT * FROM employees ORDER BY last_name ASC;

# 7
SELECT * FROM sales ORDER BY sale_date ASC;

USE company_db;
# GROUP BY :
# 1
SELECT department_id,COUNT(*) AS employee_count FROM employees GROUP BY department_id;

# 2
SELECT department_id,MAX(salary) AS max_salary FROM employees GROUP BY department_id;

# 3
SELECT department_id,MIN(salary) AS min_salary FROM employees GROUP BY department_id;

# 4
SELECT department_id,SUM(salary) AS total_salary FROM employees GROUP BY department_id ORDER BY total_salary DESC;

# 5
SELECT department_id,AVG(salary) AS avg_salary FROM employees GROUP BY department_id;

# 6
SELECT employee_id,COUNT(*) AS sale_count FROM sales GROUP BY employee_id;

# 7
SELECT employee_id,SUM(amount) AS total_amount FROM sales GROUP BY employee_id ORDER BY total_amount DESC;

# 8
SELECT employee_id,AVG(amount) AS avg_amount FROM sales GROUP BY employee_id;

# 9
SELECT product_name,COUNT(*) AS sale_count FROM sales GROUP BY product_name;

# 10
SELECT product_name,MAX(amount) AS max_name FROM sales GROUP BY product_name;

# HAVING :
# 1
SELECT department_id,COUNT(*) AS employee_count FROM employees GROUP BY department_id HAVING COUNT(*) > 2;

# 2
SELECT department_id,SUM(salary) AS total_salary FROM employees GROUP BY department_id HAVING SUM(salary) > 100000;

# 3
SELECT department_id,MIN(salary) AS min_salary FROM employees GROUP BY department_id HAVING MIN(salary) > 45000;

# 4
SELECT product_name,COUNT(*) AS sale_count FROM sales GROUP BY product_name HAVING COUNT(*) > 1;

# 5
SELECT product_name,MAX(amount) AS max_amount FROM sales GROUP BY product_name HAVING MAX(amount) > 70000;

# 6
SELECT employee_id,SUM(amount) AS total_amount FROM sales GROUP BY employee_id HAVING SUM(amount) > 70000;

# 7
SELECT employee_id,AVG(amount) AS avg_amount FROM sales GROUP BY employee_id HAVING AVG(amount) > 30000;

# 8
SELECT department_id,AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING AVG(salary) < 50000;










