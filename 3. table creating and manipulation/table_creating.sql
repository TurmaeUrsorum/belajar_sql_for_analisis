-- Active: 1728529519693@@127.0.0.1@3306@sdm
CREATE Table sdm.karyawan (
    nik VARCHAR(16),
    nama_karyawan VARCHAR(50),
    level_jabatan INTEGER,
    tanggal_lahir DATE
)

show TABLES

INSERT INTO karyawan VALUES(
    "A01",
    "Andi",
    2,
    "1997-09-08"
)

INSERT INTO karyawan VALUES(
    "A02",
    "Arif",
    3,
    "1990-09-08"
)

SELECT * FROM karyawan

SELECT nik FROM karyawan

SELECT nik as Id_Karyawan FROM karyawan