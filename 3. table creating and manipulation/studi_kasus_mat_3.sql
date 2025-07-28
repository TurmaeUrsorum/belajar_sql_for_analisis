-- Active: 1728529519693@@127.0.0.1@3306@studi_kasus_mskill_3
-- id siswa int not null
-- nama varchar not null
-- tanggal lahir datetime 
-- sekolah varchar not null
-- alamat text 
-- waktu di buat datetime

CREATE table siswa (
    id_siswa int NOT NULL,
    nama VARCHAR(50) NOT NULL,
    tanggal_lahir DATETIME,
    sekolah VARCHAR(50) NOT NULL,
    alamat TEXT,
    create_at DATETIME
)

select * FROM siswa

INSERT into siswa VALUES (
    1,
    "Andi",
    "1997-09-08",
    "SMK Negeri 1",
    "Jl. Raya No. 1",
    "2022-01-01 00:00:00"
)

INSERT into siswa VALUES (
    2,
    "Budi",
    "1997-09-08",
    "SMK Negeri 1",
    "Jl. Raya No. 1",
    "2022-01-01 00:00:00"
)