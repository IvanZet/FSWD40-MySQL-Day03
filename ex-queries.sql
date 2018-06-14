--done 4. Report:
--How many employees do we have that are working for us since 1985 and
--who are they?

SELECT COUNT(*)
FROM employees
WHERE hire_date >= '1985-01-01';

SELECT first_name, last_name
FROM employees
WHERE hire_date >= '1985-01-01';

--done 5. Report:
--How many employees got hired from 1990 until 1997 and who are they?

SELECT COUNT(*)
FROM employees
WHERE hire_date >= '1990-01-01'
	AND hire_date <= '1997-12-31';

SELECT first_name, last_name
FROM employees
WHERE hire_date >= '1990-01-01'
	AND hire_date <= '1997-12-31';

--done 6. Report:
--How many employees have salaries higher than EUR 70 000,00 and who are they?

SELECT COUNT(*)
FROM employees
INNER JOIN salaries
	ON employees.emp_no = salaries.emp_no
WHERE salaries.salary > 70000;
--Result: 511899

SELECT first_name, last_name
FROM employees
INNER JOIN salaries
	ON employees.emp_no = salaries.emp_no
WHERE salaries.salary > 70000

--done 7. Report:
--How many employees do we have in the Research Department, who are working
--for us since 1992 and who are they?

SELECT COUNT(*)
FROM employees
INNER JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Research'
	AND employees.hire_date >= '1992-01-01'
--Result: 21126

SELECT first_name, last_name
FROM employees
INNER JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Research'
	AND employees.hire_date >= '1992-01-01';

--done 8. Report:
--How many employees do we have in the Finance Department, who are working
--for us since 1985 until now and who have salaries
--higher than EUR 75 000,00 - who are they?

SELECT COUNT(*)
FROM employees
INNER JOIN salaries
	ON employees.emp_no = salaries.emp_no
INNER JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Finance'
	AND employees.hire_date >= '1985-01-01'
	AND salaries.salary > 75000;
--36033

SELECT employees.first_name, employees.last_name
FROM employees
INNER JOIN salaries
	ON employees.emp_no = salaries.emp_no
INNER JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Finance'
	AND employees.hire_date >= '1985-01-01'
	AND salaries.salary > 75000

--done 9. Report:
--We need a table with employees , who are working for us at this moment:
--first and last name, date of birth, gender, hire_date, title and salary.

SELECT first_name, last_name, gender, hire_date, birth_date, gender, titles.title, titles.to_date AS 'Title to date', salaries.to_date AS 'Salary to date', salaries.salary
FROM employees
INNER JOIN titles
	ON employees.emp_no = titles.emp_no
INNER JOIN salaries
	ON employees.emp_no = salaries.emp_no
WHERE salaries.to_date = '9999-01-01'
    AND titles.to_date = '9999-01-01';
--emp_id to check 10004

--!!!not working: Subquery
SELECT employees.emp_no, employees.first_name, employees.last_name
FROM employees AS em
INNER JOIN titles
	ON employees.emp_no = titles.emp_no
WHERE 1 < (SELECT COUNT(*)
           FROM titles
           INNER JOIN employees
           		ON titles.emp_no = employees.emp_no
           WHERE employees.emp_no = em.emp_no);
	
--done 10. Report:
--We need a table with managers, who are working for us at this moment:
--first and last name, date of birth, gender, hire_date, title,
--department name and salary.

SELECT employees.emp_no, first_name, last_name, birth_date, gender, hire_date, titles.title, titles.to_date AS 'Title to date', departments.dept_name, salaries.salary
FROM employees
INNER JOIN dept_manager
	ON employees.emp_no = dept_manager.emp_no
INNER JOIN titles
	ON employees.emp_no = titles.emp_no
INNER JOIN departments
	ON dept_manager.dept_no = departments.dept_no
LEFT JOIN salaries
	ON employees.emp_no = salaries.emp_no
WHERE dept_manager.to_date = '9999-01-01'
	AND titles.to_date = '9999-01-01';
--emp_no 110114
--with backticks Query took 0.0062 seconds

--done Bonus query:
--Create a query which will join all tables and show all data from all
--tables.
--AND `employees`.`emp_no` = 110114

SELECT employees.emp_no, first_name, last_name, dept_emp.to_date AS 'Emp dep to date', dept_manager.to_date AS 'Man dep to date', departments.dept_name, salaries.salary, salaries.to_date AS 'Sal to date', titles.title, titles.to_date AS 'Title to date'
FROM employees
LEFT JOIN dept_emp
    ON employees.emp_no = dept_emp.emp_no
LEFT JOIN dept_manager
    ON employees.emp_no = dept_manager.emp_no
LEFT JOIN departments
    ON employees.emp_no = departments.dept_no
LEFT JOIN salaries
    ON employees.emp_no = salaries.emp_no
LEFT JOIN titles
    ON employees.emp_no = titles.emp_no
WHERE titles.to_date = '9999-01-01'
    AND dept_emp.to_date = '9999-01-01'
    AND dept_manager.to_date = '9999-01-01'
    AND (salaries.to_date = '9999-01-01' OR salaries.to_date IS null)

--done)
