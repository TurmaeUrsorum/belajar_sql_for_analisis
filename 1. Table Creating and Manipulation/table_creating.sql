-- Active: 1728529519693@@127.0.0.1@3306@sdm

CREATE TABLE sdm.karyawan (
  nik VARCHAR (16),
  nama_karyawan VARCHAR (50),
  level_jabatan INTEGER,
  tanggal_lahir DATE
);

SELECT * FROM sdm.karyawan;

DESC sdm.karyawan;