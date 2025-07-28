-- Active: 1728529519693@@127.0.0.1@3306@universitas
CREATE TABLE dosen (
    id_dosen varchar(50) NOT NULL PRIMARY KEY,
    nama_dosen varchar(100),
    prog_studi varchar(100)
)

DESCRIBE dosen

CREATE TABLE mahasiswa (
    id_mahasiswa VARCHAR(50) NOT NULL PRIMARY KEY,
    nama_mahasiswa VARCHAR(100),
    id_dosen_wali VARCHAR(100),

    Foreign Key (id_dosen_wali) REFERENCES dosen(id_dosen)
)

DESCRIBE mahasiswa

INSERT INTO
    universitas.dosen (id_dosen, nama_dosen, prog_studi)
VALUES
    ('A1001', 'Mali, Ph.D', 'Teknik Industri'),
    ('A1003', 'Dr. Margareta', 'Matematika'),
    ('A1004', 'Adi, S.E., MBA', 'Manajemen'),
    ('A1005', 'Mali, Ph.D', 'Manajemen');

SELECT * FROM dosen

INSERT INTO
    universitas.mahasiswa(id_mahasiswa, nama_mahasiswa, id_dosen_wali)
VALUES
    ('13217073', 'Aruman', 'A1005');

SELECT * FROM mahasiswa

EXPLAIN universitas.mahasiswa

-- Alter table nih

ALTER Table universitas.mahasiswa
MODIFY 
COLUMN id_mahasiswa INTEGER;

DESCRIBE universitas.mahasiswa;

alter Table universitas.mahasiswa
CHANGE COLUMN
id_mahasiswa nomor_induk_mahasiswa INTEGER;

DESCRIBE universitas.mahasiswa