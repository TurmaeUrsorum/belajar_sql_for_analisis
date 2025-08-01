-- Active: 1728529519693@@127.0.0.1@3306@Subquery_and_Common_Table_Expression
SHOW TABLES CREATE TABLE produk (
    id INT PRIMARY KEY,
    nama_produk VARCHAR(50),
    harga INT,
    terjual INT
);

DESCRIBE produk;

INSERT INTO
    produk (id, nama_produk, harga, terjual)
VALUES
    (1, 'Sabun Mandi', 10000, 100),
    (2, 'Pasta Gigi', 15000, 80),
    (3, 'Shampo', 20000, 120),
    (4, 'Deterjen', 25000, 90);

SELECT
    *
FROM
    produk;

--1 Pada tabel products berikut, dengan menggunakan subquery, 
--temukan produk dengan harga lebih tinggi dari rata-rata harga semua produk!
SELECT
    *
FROM
    produk
WHERE
    harga > (
        SELECT
            AVG(harga)
        FROM
            produk
    )


CREATE TABLE transaksi (
    id INT PRIMARY KEY,
    id_pelanggan INT,
    tanggal DATE,
    total_pembelian INT
);

INSERT INTO transaksi (id, id_pelanggan, tanggal, total_pembelian) VALUES
(1, 1, '2023-11-01', 100000),
(2, 2, '2023-11-02', 150000),
(3, 1, '2023-11-03', 200000),
(4, 3, '2023-11-04', 250000);

SELECT * FROM transaksi

--2 Dari tabel orders berikut, dengan menggunakan Common Table Expression, 
-- temukan total pembelian untuk setiap pelanggan dan urutkan berdasarkan 
-- total pembelian dari tertinggi ke terendah!

WITH customer_filter AS (
    SELECT
        id_pelanggan,
        SUM(total_pembelian) AS total
    FROM transaksi
    GROUP BY id_pelanggan
)
SELECT *
FROM customer_filter
ORDER BY total DESC
LIMIT 100;


--3 Perhatikan query SQL berikut! Jelaskan apa yang dilakukan masing-masing CTE dan apa yang ditampilkan oleh query secara keseluruhan!


WITH 
-- 1. nih func menselect customer ama total pembelian terus di group by berdasarkan customer countery
total_pembelian_per_negara AS (
  SELECT 
    customer_country,
    SUM(order_total) AS total_pembelian
  FROM orders
  GROUP BY customer_country
),
--2 nih func menselect customer id,name, country ama total pembelian(dari CTE total pembelian per negara)
-- terus di join ama customers, ini recursive CTE yak yang pelanggan terloyal
-- setelah di join berdasarkan country, di order by total pembelian desc, limit 1
pelanggan_terloyal AS (
  SELECT customer_id,
  customer_name,
  customer_country,
  total_pembelian
  FROM total_pembelian_per_negara
  INNER JOIN customers ON customers.customer_country = total_pembelian_per_negara.customer_country
  ORDER BY total_pembelian DESC
  LIMIT 1
)
-- lalu dipanggil yang pelanggan royal, ambil kolom customer name, customer country
SELECT customer_name, customer_country
FROM pelanggan_terloyal;
