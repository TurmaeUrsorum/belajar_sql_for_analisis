-- Active: 1728529519693@@127.0.0.1@3306@student_peformance

SELECT * FROM `Students_Performance`

SELECT COUNT(*) FROM `Students_Performance`

--1 get data all untuk student

DELIMITER //
CREATE PROCEDURE getAllData ()
BEGIN
    SELECT * FROM `Students_Performance`;
END //
DELIMITER ;

SHOW PROCEDURE STATUS;

DROP Procedure getAllData();

CALL getAllData();

--2 

DELIMITER //
CREATE PROCEDURE getAllDataRace1 (
    IN ras VARCHAR(100)
)
BEGIN
    SELECT * FROM `Students_Performance` WHERE race_or_ethnicity = ras;
END //
DELIMITER ;

SHOW PROCEDURE STATUS

DROP Procedure getAllDataRace1


CALL getAllDataRace1("group B")

--3 A

DELIMITER //
CREATE PROCEDURE getAllDataRace2 ()
BEGIN
    SELECT race_or_ethnicity, AVG(math_score) FROM `Students_Performance` GROUP BY race_or_ethnicity;
END //
DELIMITER ;

SHOW PROCEDURE STATUS

DROP Procedure getAllDataRace2

CALL getAllDataRace2

--3 B

DELIMITER //
CREATE PROCEDURE getAllDataRace3 (
    OUT avg_nilai_math INT
)
BEGIN
    SELECT
        AVG(math_score) INTO avg_nilai_math
    FROM
        `Students_Performance`;

    SELECT 
        *
    FROM `Students_Performance`
    WHERE math_score > avg_nilai_math;
END //
DELIMITER ;

SHOW PROCEDURE STATUS

DROP Procedure getAllDataRace3

CALL getAllDataRace3(@lebih_dari_avg)

SELECT @lebih_dari_avg

-- 4

DELIMITER //
CREATE PROCEDURE get_gender_math_score (
    INOUT Jenis_Gender VARCHAR(100),
    INOUT rerata_nilai_math FLOAT
)
BEGIN
    SELECT
        AVG(math_score) INTO rerata_nilai_math
    FROM
        `Students_Performance`
    WHERE gender = Jenis_Gender;

    SELECT
        gender INTO Jenis_Gender
    FROM
        `Students_Performance` WHERE gender = Jenis_Gender LIMIT 1;
END //
DELIMITER ;

SHOW PROCEDURE STATUS

DROP Procedure get_gender_math_score

SET @Jenis_Gender = "male"

CALL get_gender_math_score(@Jenis_Gender, @rerata_nilai_math)

SELECT @Jenis_Gender, @rerata_nilai_math





