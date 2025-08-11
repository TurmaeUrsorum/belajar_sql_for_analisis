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

SELECT DISTINCT(experience_level) FROM ds_salaries


--1 apakah ada data yang null ?

SELECT * FROM ds_salaries
WHERE work_year IS NULL
OR experience_level IS NULL
OR employment_type IS NULL
OR job_title IS NULL
OR salary IS NULL
OR salary_currency IS NULL
OR salary_in_usd IS NULL
OR employee_residence IS NULL
OR remote_ratio IS NULL
OR company_location IS NULL
OR company_size IS NULL

--2 melihat ada job title apa saja

SELECT DISTINCT(job_title) FROM ds_salaries ORDER BY job_title

--3 job title apa saja yang berkaitan dengan data analyst

SELECT DISTINCT(job_title) FROM ds_salaries
WHERE job_title LIKE '%data analyst%'

--4 berapa gaji rata rata data analyst ?

SELECT 
    DISTINCT(job_title),
    AVG(salary_in_usd) 
FROM 
    ds_salaries
WHERE 
    job_title LIKE '%data analyst%' 
GROUP BY 
    job_title

-- 4.1 Berapa rata-rata gaji data analyst berdasarkan experience levelnya?

SELECT 
    experience_level,
    AVG(salary_in_usd) as avg_salary_in_usd
FROM 
    ds_salaries
WHERE 
    job_title LIKE '%data analyst%'
GROUP BY 
    experience_level
ORDER BY 
    avg_salary_in_usd DESC;

-- 4.2 Berapa rata-rata gaji data analyst berdasarkan experience level dan jenis employment?

SELECT 
    experience_level,
    employment_type,
    AVG(salary_in_usd) as avg_salary_in_usd
FROM 
    ds_salaries
WHERE 
    job_title LIKE '%data analyst%'
GROUP BY 
    experience_level, employment_type
ORDER BY 
    avg_salary_in_usd DESC;

-- 5. Negara dengan gaji yang menarik untuk posisi data analyst, full time, exp kerjanya entry level dan menengah / mid

SELECT
    company_location,
    experience_level,
    employment_type,
    AVG(salary_in_usd) as avg_salary_in_usd
FROM 
    ds_salaries
WHERE 
    job_title LIKE '%data analyst%'
    AND experience_level IN ('EN', 'MI')
    AND employment_type = 'FT'
GROUP BY 
    experience_level, employment_type, company_location
ORDER BY 
    avg_salary_in_usd DESC;

-- 6. Di tahun berapa, kenaikan gaji dari mid ke senior itu memiliki kenaikan yang tertinggi? 
-- (untuk pekerjaan yang berkaitan dengan data analyst yang penuh waktu

WITH ds_1 AS (
	SELECT
		work_year,
		AVG(salary_in_usd) sal_in_usd_ex
	FROM
		ds_salaries
	WHERE
		employment_type = 'FT'
		AND experience_level = 'EX'
		AND job_title LIKE '%data analyst%'
	GROUP BY
		work_year
),
ds_2 AS (
	SELECT
		work_year,
		AVG(salary_in_usd) sal_in_usd_mi
	FROM
		ds_salaries
	WHERE
		employment_type = 'FT'
		AND experience_level = 'MI'
		AND job_title LIKE '%data analyst%'
	GROUP BY
		work_year
),
t_year AS (
	SELECT
		DISTINCT work_year
	FROM
		ds_salaries
)
SELECT
	t_year.work_year,
	ds_1.sal_in_usd_ex,
	ds_2.sal_in_usd_mi,
	ds_1.sal_in_usd_ex - ds_2.sal_in_usd_mi differences
FROM
	t_year
	LEFT JOIN ds_1 ON ds_1.work_year = t_year.work_year
	LEFT JOIN ds_2 ON ds_2.work_year = t_year.work_year;