-- Active: 1728529519693@@127.0.0.1@3306@student_peformance
SHOW TABLES -- /home/brilly/Documents/StudentsPerformance.csv

create Table Students_Performance (
    gender TEXT NOT NULL,
    race_or_ethnicity TEXT NOT NULL,
    parental_level_of_education TEXT NOT NULL,
    lunch TEXT NOT NULL,
    test_preparation_course TEXT NOT NULL,
    math_score INT NOT NULL,
    reading_score INT NOT NULL,
    writing_score INT NOT NULL
)

DESC `Students_Performance`

LOAD DATA INFILE '/var/lib/mysql-files/StudentsPerformance.csv'
INTO TABLE Students_Performance
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(gender, race_or_ethnicity, parental_level_of_education, lunch, test_preparation_course, math_score, reading_score, writing_score);

--1
SELECT * FROM Students_Performance

--2
SELECT DISTINCT race_or_ethnicity FROM Students_Performance ORDER BY race_or_ethnicity

--3 
SELECT race_or_ethnicity FROM `Students_Performance` WHERE math_score = 0;

--4

SELECT * FROM `Students_Performance` WHERE parental_level_of_education = "associate's degree" ORDER BY writing_score LIMIT 1

--5
SELECT * FROM `Students_Performance` WHERE race_or_ethnicity IN ('group A', 'group B') ORDER BY writing_score -- 19
    -- 19 + 15 = 34

--6

SELECT
    *
FROM
    `Students_Performance`
WHERE
    writing_score > 80
    AND math_score < 65
ORDER BY
    writing_score ASC;;

--7

SELECT
    *
FROM
    `Students_Performance`
WHERE
    reading_score > 10
    AND reading_score < 25
ORDER BY
    reading_score ASC;