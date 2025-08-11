-- Active: 1728529519693@@127.0.0.1@3306@sql_practice


SHOW tables

CREATE TABLE ds_salaries (
    id INT, -- bisa ganti dari Unnamed: 0 kalau mau jadi PK
    work_year INT NOT NULL,
    experience_level VARCHAR(10) NOT NULL,
    employment_type VARCHAR(10) NOT NULL,
    job_title VARCHAR(255) NOT NULL,
    salary BIGINT NOT NULL,
    salary_currency VARCHAR(10) NOT NULL,
    salary_in_usd BIGINT NOT NULL,
    employee_residence VARCHAR(10) NOT NULL,
    remote_ratio INT NOT NULL,
    company_location VARCHAR(10) NOT NULL,
    company_size VARCHAR(5) NOT NULL
);

DROP Table ds_salaries

LOAD DATA INFILE '/var/lib/mysql-files/ds_salaries.csv'
INTO TABLE ds_salaries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size);

SELECT * FROM ds_salaries
