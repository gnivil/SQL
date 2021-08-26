--List the tables for each of the six CSV files
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT A.emp_no,A.last_name,A.first_name,A.sex,B.salary 
FROM employees AS A 
LEFT JOIN salaries AS B 
ON A.emp_no=B.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM employees
WHERE date_part('year', hire_date) = '1986';

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT A.dept_no, B.dept_name, A.emp_no, C.last_name, C.first_name
FROM dept_manager AS A
LEFT JOIN departments AS B
ON A.dept_no=B.dept_no  
LEFT JOIN employees AS C
ON A.emp_no=C.emp_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT A.emp_no,B.last_name,B.first_name,C.dept_name
FROM dept_emp AS A
LEFT JOIN employees AS B
ON A.emp_no=B.emp_no
LEFT JOIN departments AS C
ON A.dept_no=C.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex FROM employees
Where first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT A.emp_no,B.last_name,B.first_name,C.dept_name
FROM dept_emp AS A
LEFT JOIN employees AS B
ON A.emp_no=B.emp_no
LEFT JOIN departments AS C
ON A.dept_no=C.dept_no
WHERE C.dept_name='Sales';

--List all employees in the Sales and Development departments
--including their employee number, last name, first name, and department name.
SELECT A.emp_no,B.last_name,B.first_name,C.dept_name
FROM dept_emp AS A
LEFT JOIN employees AS B
ON A.emp_no=B.emp_no
LEFT JOIN departments AS C
ON A.dept_no=C.dept_no
WHERE C.dept_name='Sales'
OR C.dept_name='Development';

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT(*) FROM employees
GROUP BY last_name 
ORDER BY COUNT(*) DESC;

--'Search your ID number'
SELECT A.emp_no,A.emp_title_id,B.title,A.birth_date,A.first_name,A.last_name,A.sex,A.hire_date,C.dept_no,D.dept_name,E.salary
FROM employees AS A
LEFT JOIN titles AS B
ON A.emp_title_id=B.title_id
LEFT JOIN dept_emp AS C
ON A.emp_no=C.emp_no
LEFT JOIN departments AS D
ON C.dept_no=D.dept_no
LEFT JOIN salaries as E
ON A.emp_no=E.emp_no
WHERE A.emp_no='499942';


