# SQL-Challenge

## Employee Database: A Mystery in Two Parts

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:

* Data Modeling and Data Engineering

* Data Analysis

-----

# Data Modeling

![alt text](http://url/to/img.png)

-----

# Set up jupyter notebook

~~~~sql
--List the tables for each of the six CSV files
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
~~~~