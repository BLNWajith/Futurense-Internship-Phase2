-- 1
SELECT COUNT(DISTINCT job_id) AS num_jobs FROM employees;

-- 2
SELECT SUM(salary) AS total_salaries FROM employees;

-- 3
SELECT MIN(salary) AS min_salary FROM employees;

-- 4
SELECT MAX(salary) AS max_programmer_salary FROM employees WHERE job_id = 'Programmer';

-- 5
SELECT AVG(salary) AS avg_salary, COUNT(*) AS num_employees FROM employees WHERE department_id = 90;

-- 6
SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary, SUM(salary) AS total_salary, AVG(salary) AS avg_salary FROM employees;

-- 7
SELECT job_id, COUNT(*) AS num_employees_with_job FROM employees GROUP BY job_id;

-- 8
SELECT MAX(salary) - MIN(salary) AS salary_difference FROM employees;

-- 9
SELECT manager_id, MIN(salary) AS min_salary_for_manager FROM employees GROUP BY manager_id;

-- 10
SELECT department_id, SUM(salary) AS total_salary_payable FROM employees GROUP BY department_id;

-- 11
SELECT job_id, AVG(salary) AS avg_salary FROM employees WHERE job_id <> 'Programmer' GROUP BY job_id;

-- 12
SELECT job_id, SUM(salary) AS total_salary, MAX(salary) AS max_salary, MIN(salary) AS min_salary, AVG(salary) AS avg_salary FROM employees WHERE department_id = 90 GROUP BY job_id;

-- 13
SELECT job_id, MAX(salary) AS max_salary FROM employees WHERE salary >= 4000 GROUP BY job_id;

-- 14
SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING COUNT(*) > 10;
