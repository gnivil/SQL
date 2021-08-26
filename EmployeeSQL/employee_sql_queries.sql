-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT A.emp_no,A.last_name,A.first_name,A.sex,B.salary FROM employees AS A 
LEFT JOIN salaries AS B 
ON A.emp_no=B.emp_no;


