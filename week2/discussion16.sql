-- 1
-- Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name".
select first_name "First Name",last_name "Last Name"from employees,limit 5

-- 2
-- Write a query to get unique department ID from employee table.
select distinct(DEPARTMENT_ID) from employees;

-- 3
-- Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary).
SELECT concat(first_name, " ", last_name),salary, 0.15 * salary PF from employees; 

-- 4
-- Write a query to get the maximum and minimum salary from employees table.
select max(SALARY) "MAX SALARY", min(SALARY) "MIN SALARY" from employees;

-- 5
-- Write a query to get the average salary and number of employees in the employees table.
select AVG(SALARY) "AVERAGE SALARY", COUNT(SALARY) "SALARY COUNT" from employees;

-- 6
-- Write a query get all first name from employees table in upper case.
select UPPER(FIRST_NAME) from employees;

-- 7
-- Write a query to get the first 3 characters of first name from employees table.
select SUBSTRING(FIRST_NAME, 1, 3) from employees;

-- 8
-- Write a query to select first 10 records from a table.
SELECT * FROM employees LIMIT 10;

-- 9
-- Write a query to get monthly salary (round 2 decimal places) of each and every employee.
SELECT EMPLOYEE_ID "ID", fIRST_NAME "NAME", SALARY * 0.08 "mONTHLY SALARY" FROM employees;

-- 10
-- Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order.
SELECT concat(first_name, " ", last_name), DEPARTMENT_ID from employees WHERE DEPARTMENT_ID IN (30, 100) ORDER BY FIRST_NAME;