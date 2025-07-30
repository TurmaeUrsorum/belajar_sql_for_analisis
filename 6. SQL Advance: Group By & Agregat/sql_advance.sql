-- Active: 1728529519693@@127.0.0.1@3306@umkm
SELECT * FROM umkm_jabar

SELECT
    *
FROM
    umkm_jabar;

-- 1. Berapa jumlah baris pada tabel umkm_jabar?
SELECT
    COUNT(*) AS jumlah_baris
FROM
    umkm_jabar;

-- 2. Berapa jumlah UMKM di Kabupaten Bekasi pada tahun 2017?
SELECT
    SUM(jumlah_umkm) AS jumlah_umkm_kab_bekasi_2017
FROM
    umkm_jabar
WHERE
    nama_kabupaten_kota = "KABUPATEN BEKASI"
    AND tahun = 2017;

-- 3. Bagaimana tren jumlah UMKM di Kabupaten Karawang dari dari tahun 2017 s.d. 2021?
SELECT
    tahun,
    SUM(jumlah_umkm) AS jumlah_umkm_bekasi
FROM
    umkm_jabar
WHERE
    nama_kabupaten_kota = "KABUPATEN KARAWANG"
    AND tahun BETWEEN 2017
    AND 2021
GROUP BY
    tahun
ORDER BY
    tahun ASC;

-- 4. Berapa jumlah rata-rata UMKM setiap kategori usaha di setiap kabupaten/kota di jawa barat dari tahun ke tahun?
-- REVISI 4. Berapa jumlah rata-rata UMKM setiap kategori usaha per kab/kota di jawa barat dari tahun ke tahun?
SELECT
    tahun,
    kategori_usaha,
    AVG(jumlah_umkm) AS rerata_jumlah_umkm_per_kab_kota
FROM
    umkm_jabar
GROUP BY
    tahun,
    kategori_usaha
ORDER BY
    kategori_usaha,
    tahun ASC;

-- 5. Kategori usaha dengan jumlah_umkm terbanyak dan tersedikit di Kabupaten Sukabumi pada tahun 2021?
-- Query nomor 5 direvisi
/* Jawaban 5 versi 1 menggunakan subquery yang akan dijelaskan pada modul selanjutnya
Pertanyaan nomor 5 dapat dijawab juga menggunakan query pada jawaban 5 versi 2
*/

-- Jawaban 5 versi 1
SELECT
    kategori_usaha,
    jumlah_umkm
FROM
    umkm_jabar
WHERE
    nama_kabupaten_kota = "KABUPATEN SUKABUMI"
    AND tahun = 2021
    AND jumlah_umkm = (
        SELECT
            MAX(jumlah_umkm)
        FROM
            umkm_jabar
        WHERE
            nama_kabupaten_kota = "KABUPATEN SUKABUMI"
            AND tahun = 2021
    );

-- Jawaban 5 versi 2

SELECT
    *
FROM
    umkm_jabar
WHERE
    nama_kabupaten_kota = "KABUPATEN SUKABUMI"
    AND tahun = 2021
ORDER BY
    jumlah_umkm DESC;

-- Untuk jawaban tersedikit, bisa dimodifikasi jawaban 5 versi 1 dengan mengganti fungsi max menjadi min dan mengganti DESC menjadi ASC pada jawaban 5 versi 2

-- 6. Kabupaten kota dengan jumlah UMKM kurang dari 100.000 pada tahun 2020
SELECT
    nama_kabupaten_kota,
    SUM(jumlah_umkm) AS jumlah_umkm
FROM
    umkm_jabar
WHERE
    tahun = 2020
GROUP BY
    nama_kabupaten_kota
HAVING
    jumlah_umkm < 100000;