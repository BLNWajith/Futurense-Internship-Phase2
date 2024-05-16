-- 1
-- Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
SELECT e.first_name, e.last_name, e.salary FROM employees e WHERE e.salary > (SELECT salary FROM employees WHERE last_name = 'Bull');

-- 2
-- Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
SELECT e.first_name, e.last_name FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.department_name = 'IT';

-- 3
-- Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA-based department.
SELECT e.first_name, e.last_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN locations l ON d.location_id = l.location_id WHERE e.manager_id IS NOT NULL AND l.country_id = 'USA';

-- 4
-- Write a query to find the name (first_name, last_name) of the employees who are managers.
SELECT e.first_name, e.last_name FROM employees e WHERE EXISTS (SELECT 1 FROM departments d WHERE d.manager_id = e.employee_id);

-- 5
-- Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
SELECT first_name, last_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

-- 6
-- Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their jobs.
SELECT e.first_name, e.last_name, e.salary FROM employees e JOIN jobs j ON e.job_id = j.job_id WHERE e.salary = j.min_salary;

-- 7
-- Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments.
SELECT e.first_name, e.last_name, e.salary FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE e.salary > (SELECT AVG(salary) FROM employees) AND d.department_name = 'IT';

-- 8
-- Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earnings of Mr. Bell.
SELECT e.first_name, e.last_name, e.salary FROM employees e WHERE e.salary > (SELECT salary FROM employees WHERE last_name = 'Bell');

-- 9
-- Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
SELECT e.first_name, e.last_name, e.salary FROM employees e WHERE e.salary = (SELECT MIN(salary) FROM employees);

-- 10
-- Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
SELECT e.first_name, e.last_name, e.salary FROM employees e WHERE e.salary > (SELECT AVG(salary) FROM employees);

-- 11
-- Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary from the lowest to highest.
SELECT e.first_name, e.last_name, e.salary FROM employees e WHERE e.salary > ALL (SELECT salary FROM employees WHERE job_id = 'SH_CLERK') ORDER BY e.salary ASC;

-- 12
-- Write a query to find the name (first_name, last_name) of the employees who are not managers.
SELECT e.first_name, e.last_name FROM employees e WHERE e.employee_id NOT IN (SELECT manager_id FROM departments WHERE manager_id IS NOT NULL);

-- 13
-- Write a query to display the employee ID, first name, last name, and department names of all employees.
SELECT e.employee_id, e.first_name, e.last_name, d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id;

-- 14
-- Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
SELECT e.employee_id, e.first_name, e.last_name, e.salary FROM employees e WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- 15
-- Write a query to fetch even numbered records from employees table.
SELECT * FROM employees WHERE MOD(employee_id, 2) = 0;

-- 16
-- Write a query to find the 5th maximum salary in the employees table.
SELECT DISTINCT salary FROM employees e ORDER BY salary DESC LIMIT 1 OFFSET 4;

-- 17
-- Write a query to find the 4th minimum salary in the employees table.
SELECT DISTINCT salary FROM employees e ORDER BY salary ASC LIMIT 1 OFFSET 3;

-- 18
-- Write a query to select the last 10 records from a table.
SELECT * FROM (SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10) AS last_records ORDER BY employee_id ASC;

-- 19
-- Write a query to list the department ID and name of all the departments where no employee is working.
SELECT d.department_id, d.department_name FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id WHERE e.employee_id IS NULL;

-- 20
-- Write a query to get 3 maximum salaries.
SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 3;

-- 21
-- Write a query to get 3 minimum salaries.
SELECT DISTINCT salary FROM employees ORDER BY salary ASC LIMIT 3;

-- 22
-- Write a query to get nth max salaries of employees.
SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 1 OFFSET N-1;