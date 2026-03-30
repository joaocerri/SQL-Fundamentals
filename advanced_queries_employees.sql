USE employees;

SELECT e.emp_no, e.first_name, e.last_name, s.salary, d.dept_name 
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no 
INNER JOIN dept_emp de ON e.emp_no = de.emp_no 
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC;

SELECT AVG(s.salary) AS media_salario, d.dept_name
FROM salaries s
LEFT JOIN dept_emp dp ON s.emp_no = dp.emp_no 
LEFT JOIN departments d ON dp.dept_no = d.dept_no
WHERE s.to_date = '9999-01-01' AND dp.to_date = '9999-01-01' 
GROUP BY d.dept_name
ORDER BY media_salario DESC;

SELECT e.first_name, e.last_name, s.salary 
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' 
AND s.salary > (SELECT AVG(salary) FROM salaries WHERE to_date = '9999-01-01') 
ORDER BY s.salary ASC;

SELECT e.emp_no, e.first_name, e.last_name,
(SELECT d.dept_name 
 FROM departments d 
 INNER JOIN dept_emp de ON d.dept_no = de.dept_no 
 WHERE de.emp_no = e.emp_no AND de.to_date = '9999-01-01' 
 LIMIT 1) AS dept_name
FROM employees e;

WITH ranking_salarial AS (
    SELECT 
        d.dept_name, 
        CONCAT(e.first_name, ' ', e.last_name) AS nome, 
        s.salary, 
        RANK() OVER(PARTITION BY d.dept_name ORDER BY s.salary DESC) AS posicao
    FROM employees e
    LEFT JOIN salaries s ON e.emp_no = s.emp_no
    LEFT JOIN dept_emp dp ON e.emp_no = dp.emp_no 
    LEFT JOIN departments d ON dp.dept_no = d.dept_no
    WHERE s.to_date = '9999-01-01' AND dp.to_date = '9999-01-01'
)
SELECT * FROM ranking_salarial
WHERE posicao <= 10;