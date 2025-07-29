-- Active: 1728529519693@@127.0.0.1@3306@umkm
show tables

CREATE TABLE umkm_jabar (
  id INT PRIMARY KEY,
  kode_provinsi INT NOT NULL,
  nama_provinsi TEXT NOT NULL,
  kode_kabupaten_kota INT NOT NULL,
  nama_kabupaten_kota TEXT NOT NULL,
  kategori_usaha TEXT NOT NULL,
  jumlah_umkm INT NOT NULL,
  satuan TEXT NOT NULL,
  tahun INT NOT NULL
);


DESCRIBE umkm_jabar

LOAD DATA INFILE '/var/lib/mysql-files/umkm_jabar.csv'
INTO TABLE umkm_jabar
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, kode_provinsi, nama_provinsi, kode_kabupaten_kota, nama_kabupaten_kota, kategori_usaha, jumlah_umkm, satuan, tahun);

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM umkm_jabar;

--1.

SELECT * FROM umkm_jabar WHERE nama_kabupaten_kota = "KOTA BANDUNG";

