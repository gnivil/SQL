# SQL Challenge - Employee Database: A Mystery in Two Parts

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, I designed the tables to hold data in the CSVs, imported the CSVs into a SQL database, and answered questions about the data. In other words, performed:
* Data Modeling
* Data Engineering
* Data Analysis
-----

## Data Modeling
Entity relationship diagram (ERD) for the Pewlett Hackard employee data contained in their remaining six CSV files
![alt text](https://github.com/gnivil/sql-challenge/blob/e1761d05ca17845c104b0dec5d264875aed3617e/EmployeeSQL/employee_ERD_image.png)

-----

## Data Engineering
* Table schema for each of the six CSV files, specifying data types, primary keys, foreign keys, and other constraints
~~~~sql
CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
~~~~

* Imported each CSV file into the corresponding SQL table
~~~~sql
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
~~~~
-----

## Data Analysis
* Listed the following details for employees: employee number, last name, first name, sex, and salary
~~~~sql
SELECT A.emp_no,A.last_name,A.first_name,A.sex,B.salary 
FROM employees AS A 
LEFT JOIN salaries AS B 
ON A.emp_no=B.emp_no;
~~~~

* Listed first name, last name, and hire date for employees who were hired in 1986
~~~~sql
SELECT first_name, last_name, hire_date 
FROM employees
WHERE date_part('year', hire_date) = '1986';
~~~~

* Listed the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name
~~~~sql
SELECT A.dept_no, B.dept_name, A.emp_no, C.last_name, C.first_name
FROM dept_manager AS A
LEFT JOIN departments AS B
ON A.dept_no=B.dept_no  
LEFT JOIN employees AS C
ON A.emp_no=C.emp_no;
~~~~

* Listed the department of each employee with the following information: employee number, last name, first name, and department name
~~~~sql
SELECT A.emp_no,B.last_name,B.first_name,C.dept_name
FROM dept_emp AS A
LEFT JOIN employees AS B
ON A.emp_no=B.emp_no
LEFT JOIN departments AS C
ON A.dept_no=C.dept_no;
~~~~

* Listed first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B"
~~~~sql
SELECT first_name, last_name, sex 
FROM employees
Where first_name = 'Hercules'
AND last_name LIKE 'B%';
~~~~

* Listed all employees in the Sales department, including their employee number, last name, first name, and department name
~~~~sql
SELECT A.emp_no,B.last_name,B.first_name,C.dept_name
FROM dept_emp AS A
LEFT JOIN employees AS B
ON A.emp_no=B.emp_no
LEFT JOIN departments AS C
ON A.dept_no=C.dept_no
WHERE C.dept_name='Sales';
~~~~

* Listed all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
~~~~sql
SELECT A.emp_no,B.last_name,B.first_name,C.dept_name
FROM dept_emp AS A
LEFT JOIN employees AS B
ON A.emp_no=B.emp_no
LEFT JOIN departments AS C
ON A.dept_no=C.dept_no
WHERE C.dept_name='Sales'
OR C.dept_name='Development';
~~~~

* In descending order, listed the frequency count of employee last names, i.e., how many employees share each last name
~~~~sql
SELECT last_name, COUNT(*) 
FROM employees
GROUP BY last_name 
ORDER BY COUNT(*) DESC;
~~~~

-----

## Epilogue
* Searched for my ID number
~~~~sql
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
~~~~
-----