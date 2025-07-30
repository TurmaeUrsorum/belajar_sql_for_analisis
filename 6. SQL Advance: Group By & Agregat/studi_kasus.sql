-- Active: 1728529519693@@127.0.0.1@3306@student_peformance

--1
SELECT COUNT(*) as jumlah_baris FROM `Students_Performance`

--2 A
DESCRIBE `Students_Performance`

SELECT * FROM `Students_Performance`

SELECT
    gender,
    AVG(reading_score) as reading_score_rata_rata
FROM `Students_Performance`
GROUP BY
    gender;

--2 B
SELECT * FROM `Students_Performance`

SELECT
    parental_level_of_education,
    MAX(math_score) as math_score_max,
    MIN(math_score) as math_score_min
FROM `Students_Performance`
GROUP BY
    parental_level_of_education;

--3 
SELECT * FROM `Students_Performance`

SELECT DISTINCT test_preparation_course FROM `Students_Performance`

SELECT
    gender,
    AVG(math_score) as math_score_rata_rata,
    AVG(reading_score) as reading_score_rata_rata,
    AVG(writing_score) as writing_score_rata_rata
FROM `Students_Performance`
WHERE
    gender = "female"
    and test_preparation_course = "completed"