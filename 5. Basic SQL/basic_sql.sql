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

--2. 
SELECT * FROM umkm_jabar WHERE tahun >= 2019 ORDER BY kategori_usaha;

--2.1.

SELECT * FROM umkm_jabar WHERE tahun >= 2019 ORDER BY kategori_usaha LIMIT 10;

--3

SELECT DISTINCT kategori_usaha FROM umkm_jabar

-- 4

SELECT * FROM umkm_jabar WHERE kategori_usaha IN ("FASHION", "MINUMAN") ORDER BY kategori_usaha

-- 5

SELECT
    *
FROM
    umkm_jabar
WHERE
    nama_kabupaten_kota = "KABUPATEN KARAWANG"
    AND kategori_usaha = "FASHION"
    AND tahun IN (2017, 2021)
ORDER BY
    tahun ASC;

-- 6

SELECT
    nama_kabupaten_kota,
    kategori_usaha,
    jumlah_umkm,
    satuan,
    tahun
FROM
    umkm_jabar
WHERE
    kategori_usaha = "KULINER"
    OR kategori_usaha = "FASHION"

limit 10

-- 7. Tunjukkan seluruh data selain kategori usaha kuliner, makanan dan minuman!
SELECT
    *
FROM
    umkm_jabar
WHERE
    kategori_usaha NOT IN ("KULINER", "MAKANAN", "MINUMAN");

-- 8. Apakah terdapat id yang memiliki jumlah_umkm yang tidak diketahui (NULL)?
SELECT
    *
FROM
    umkm_jabar
WHERE
    jumlah_umkm IS NULL;

-- 9. Dari tahun 2018 s.d. 2020, bagaimana tren jumlah umkm di Kabupaten Tasikmalaya untuk kategori usaha Batik? 
SELECT
    *
FROM
    umkm_jabar
WHERE
    nama_kabupaten_kota = "Kabupaten Tasikmalaya"
    AND kategori_usaha = "BATIK"
    AND tahun BETWEEN 2018
    AND 2020
ORDER BY
    jumlah_umkm ASC;

-- 10. Di antara Kota Bandung, Kabupaten Bandung dan Kabupaten Bandung Barat, di manakah umkm kuliner terpusat pada tahun 2021?
SELECT
    *
FROM
    umkm_jabar
WHERE
    nama_kabupaten_kota LIKE "%bandung%"
    AND kategori_usaha = "KULINER"
    AND tahun = 2021
ORDER BY
    jumlah_umkm DESC;

-- 11. Kabupaten/Kota mana saja yang memiliki angka 7 pada digit ke 3 kode tersebut?
SELECT
    kode_kabupaten_kota,
    nama_kabupaten_kota
FROM
    umkm_jabar
WHERE
    kode_kabupaten_kota LIKE "__7%";

SELECT
    DISTINCT kode_kabupaten_kota,
    nama_kabupaten_kota
FROM
    umkm_jabar
WHERE
    kode_kabupaten_kota LIKE "__7%";

