-- Active: 1728529519693@@127.0.0.1@3306@str_date_manipulation

SHOW TABLES

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    hire_date DATE,
    salary DECIMAL(10,2),
    department_id INT
);

DESCRIBE employees


INSERT INTO employees (
    employee_id, first_name, last_name, birth_date, hire_date, salary, department_id
) VALUES
(1, 'John',   'Smith',   STR_TO_DATE('5/15/1980', '%m/%d/%Y'), STR_TO_DATE('2/28/2015', '%m/%d/%Y'), 60000, 1),
(2, 'Jane',   'Doe',     STR_TO_DATE('8/22/1985', '%m/%d/%Y'), STR_TO_DATE('7/15/2018', '%m/%d/%Y'), 70000, 2),
(3, 'Robert', 'Johnson', STR_TO_DATE('12/10/1990', '%m/%d/%Y'), STR_TO_DATE('1/10/2020', '%m/%d/%Y'), 80000, 1),
(4, 'Alice',  'Brown',   STR_TO_DATE('3/5/1982', '%m/%d/%Y'), STR_TO_DATE('9/20/2016', '%m/%d/%Y'), 65000, 3),
(5, 'Emily',  'Davis',   STR_TO_DATE('7/30/1988', '%m/%d/%Y'), STR_TO_DATE('11/12/2017', '%m/%d/%Y'), 75000, 2);

SELECT * FROM employees

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

DESCRIBE departments

INSERT INTO departments (department_id, department_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

SELECT * FROM departments


--1 Buatlah query untuk membuat kolom tahun dan bulan secara terpisah untuk setiap record.

SELECT
    employee_id, birth_date, hire_date, YEAR(birth_date) as Year_Birth,
    MONTH(birth_date) as Month_Birth, YEAR(hire_date) as Year_Hire,
    MONTH(hire_date) as Month_Hire
FROM employees

--2 Buatlah query untuk memunculkan karyawan dengan masa kerja 5-10 tahun.

SELECT 
  employee_id, 
  first_name,
  TIMESTAMPDIFF(YEAR, hire_date, CURRENT_DATE()) AS Tenure
FROM 
  employees
WHERE 
  TIMESTAMPDIFF(YEAR, hire_date, CURRENT_DATE()) BETWEEN 5 AND 10
ORDER BY 
  Tenure;


--3 Buatlah query untuk memunculkan nama dan department dari 
--masing-masing karyawan dengan 
--format “Last Name, First Name_Department”

SELECT
employee_id, CONCAT(last_name, ', ', first_name, '_', department_name) as Full_Name
FROM employees e
JOIN departments d ON e.department_id = d.department_id

--4 Buatlah query untuk memunculkan karyawan yang berulang tahun pada bulan ini

SELECT
    employee_id, birth_date,
    DAY(birth_date) = DAY(CURRENT_DATE()) AND MONTH(birth_date) = MONTH(CURRENT_DATE()) AS Is_Birthday
FROM employees