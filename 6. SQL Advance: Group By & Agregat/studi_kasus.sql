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

--4

SELECT * FROM `Students_Performance`

SELECT
    parental_level_of_education,
    AVG(writing_score) as writing_score_rata_rata
FROM `Students_Performance`
WHERE
    parental_level_of_education = "high school"
    OR parental_level_of_education = "some high school"
GROUP BY
    parental_level_of_education

--5
SELECT * FROM `Students_Performance`

SELECT gender,
race_or_ethnicity,
test_preparation_course,
AVG(math_score) AS avg_math_score,
AVG(reading_score) AS avg_reading_score,
AVG(writing_score) AS avg_writing_score
FROM `Students_Performance`
GROUP BY gender,
race_or_ethnicity,
test_preparation_course
ORDER BY gender,
race_or_ethnicity,
test_preparation_course;

--6

SELECT 
  gender,
  race_or_ethnicity,
  test_preparation_course,
  AVG(math_score) AS avg_math_score,
  AVG(reading_score) AS avg_reading_score,
  AVG(writing_score) AS avg_writing_score
FROM Students_Performance
GROUP BY 
  gender,
  race_or_ethnicity,
  test_preparation_course
HAVING avg_math_score > 70
ORDER BY 
  gender,
  race_or_ethnicity,
  test_preparation_course;
