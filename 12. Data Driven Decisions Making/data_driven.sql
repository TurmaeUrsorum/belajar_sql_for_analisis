-- Active: 1728529519693@@127.0.0.1@3306@Data_Driven


SHOW tables;


CREATE TABLE area (
    area VARCHAR(50),
    area_id VARCHAR(10),
    city_id VARCHAR(10),
    city VARCHAR(100),
    PRIMARY KEY (city_id)
);

INSERT INTO area (area, area_id, city_id, city) VALUES
('Jakarta', 'A01', 'C0101', 'Kota Tangerang Selatan'),
('Jakarta', 'A01', 'C0102', 'Kota Tangerang'),
('Jakarta', 'A01', 'C0103', 'Kabupaten Tangerang'),
('Jakarta', 'A01', 'C0104', 'Jakarta Pusat'),
('Jakarta', 'A01', 'C0105', 'Jakarta Timur'),
('Jakarta', 'A01', 'C0106', 'Kota Depok'),
('Jakarta', 'A01', 'C0107', 'Jakarta Selatan');

SELECT * FROM area

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE,
    area VARCHAR(50),
    area_id VARCHAR(10),
    services VARCHAR(20),
    is_fixed_price TINYINT, --harga yang sudah di setting di awal user sudah pesan, 1 untuk sudah terukur, 0 untuk belum terukur, yang 0 mirip lah ama argo
    status VARCHAR(20),
    pickup_city_id VARCHAR(10),
    pickup_suburb_id VARCHAR(10),
    pickup_district_id VARCHAR(10),
    fare INT,
    cancel_reason VARCHAR(255),
    FOREIGN KEY (pickup_city_id) REFERENCES area(city_id)
);

INSERT INTO orders (order_id, order_date, area, area_id, services, is_fixed_price, status, pickup_city_id, pickup_suburb_id, pickup_district_id, fare, cancel_reason) VALUES
('A001', '2019-02-01', 'Jakarta', 'A01', 'reguler', 1, 'Finished', 'C0101', 'S0101', 'D0201', 25000, NULL),
('A002', '2020-02-02', 'Jakarta', 'A01', 'reguler', 1, 'Finished', 'C0102', 'S0102', 'D0202', 40000, NULL),
('A003', '2021-02-03', 'Jakarta', 'A01', 'reguler', 0, 'Cancel',   'C0103', 'S0103', 'D0203', 50000, 'lokasi driver terlalu jauh'),
('A004', '2021-02-04', 'Jakarta', 'A01', 'luxury',  1, 'Finished', 'C0104', 'S0104', 'D0204', 70000, NULL),
('A005', '2022-02-05', 'Jakarta', 'A01', 'luxury',  1, 'Finished', 'C0105', 'S0105', 'D0205', 80000, NULL),
('A006', '2023-02-06', 'Jakarta', 'A01', 'luxury',  0, 'Cancel',   'C0106', 'S0106', 'D0206', 90000, 'driver tidak bergerak'),
('A007', '2020-02-07', 'Jakarta', 'A01', 'luxury',  0, 'Cancel',   'C0107', 'S0107', 'D0207', 100000, 'lokasi driver terlalu jauh');

SELECT * FROM orders

--1 jumlah order di suatu perusahaan transportasi terus menurun sejak tahun 2019

SELECT 
    EXTRACT(YEAR FROM order_date) as YEAR,
    Count(DISTINCT order_id) as total_order,
    SUM(fare) as total_fare
FROM 
    orders
GROUP BY
    1

-- 2
-- a. mengapa jumlah order menuru ?
-- b. bagaiman cara agar order menjadi terus naik kembali

-- 2a
SELECT 
    EXTRACT(YEAR FROM order_date) as YEAR,
    SUM(if (is_fixed_price=1,1,0)) as fixed_price,
    SUM(if (is_fixed_price=0,1,0)) as not_fixed_price
FROM 
    orders
GROUP BY
    1
-- 2b mengapa jumlah order fixed price menurun ?

SELECT * FROM orders WHERE status='Cancel'

SELECT EXTRACT(YEAR FROM order_date) as year FROM orders;

SELECT
    EXTRACT(YEAR FROM order_date) as YEAR,
    SUM(IF(is_fixed_price=1 AND status="Cancel",1,0))/SUM(IF(is_fixed_price=1,1,0)) as fixed_price_cancel,
    SUM(IF(is_fixed_price=0 AND status="Cancel",1,0))/SUM(IF(is_fixed_price=0,1,0)) as not_fixed_price_cancel
FROM 
    orders
GROUP BY
    1

--2c mengapa cancellation rate pada order fixed meningkat

SELECT 
    EXTRACT(YEAR FROM order_date) as YEAR,
    cancel_reason,
    COUNT(DISTINCT order_id) as total_order
FROM 
    orders
WHERE is_fixed_price=1
GROUP BY
    1,2

--2d bagaiaman sebaran cancel karena lokasi driver terlalu jauh per daerah

SELECT* FROM orders

SELECT * FROM area

SELECT
    COUNT(DISTINCT order_id) as total_order,
    a.city,
    o.cancel_reason
FROM 
    orders o
LEFT JOIN area a 
    ON o.area_id = a.area_id
WHERE 
    cancel_reason = 'lokasi driver terlalu jauh'
GROUP BY
    2