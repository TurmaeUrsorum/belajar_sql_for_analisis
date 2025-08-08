-- Active: 1728529519693@@127.0.0.1@3306@bisnis_analisi_sql

show TABLEs

CREATE TABLE `order` (
    order_date DATE,
    order_id BIGINT PRIMARY KEY,
    user_id VARCHAR(10),
    services VARCHAR(20),
    area VARCHAR(50),
    flag_fall INT,
    distance INT
);

INSERT INTO `order` (order_date, order_id, user_id, services, area, flag_fall, distance) VALUES
('2024-03-01', 1010101, 'A0001', 'reguler', 'Jakarta', 9000, 10),
('2024-03-01', 1010102, 'A0002', 'reguler', 'Jakarta', 9000, 15),
('2024-03-01', 1010103, 'A0003', 'reguler', 'Jakarta', 9000, 20),
('2024-03-02', 1010104, 'A0004', 'luxury',  'Jakarta', 25000, 25),
('2024-03-02', 1010105, 'A0005', 'luxury',  'Jakarta', 25000, 21),
('2024-03-05', 1010106, 'A0006', 'luxury',  'Jakarta', 25000, 32),
('2024-03-05', 1010107, 'A0007', 'reguler', 'Jakarta', 9000, 17);

CREATE TABLE fare (
    area VARCHAR(50),
    services VARCHAR(20),
    drop_off INT
);

INSERT INTO fare (area, services, drop_off) VALUES
('Jakarta', 'reguler', 8000),
('Jakarta', 'luxury', 15000);

CREATE TABLE drivers_commission (
    area VARCHAR(50),
    services VARCHAR(20),
    commission DECIMAL(3,2)
);

INSERT INTO drivers_commission (area, services, commission) VALUES
('Jakarta', 'reguler', 0.3),
('Jakarta', 'luxury', 0.4);

--1 suatu perusahaan transportasi meminta anda untuk menghitung revenue per tanggal
-- rumus revenue = total fare = flag_fall + distance * drop_off
SELECT
    order_date,
    SUM(flag_fall + (distance * drop_off)) as revenue 
FROM 
    `order` o
left JOIN fare f
    ON o.services = f.services
    AND o.area = f.area
GROUP BY order_date

--2 menghitung cost pada setiap tanggal
-- rumus cost: driver_commission = total fare * commission / 100

SELECT
    order_date,
    SUM((flag_fall + (distance * drop_off)) * commission) as cost
FROM 
    `order`
LEFT JOIN fare f 
    ON `order`.services = f.services
    AND `order`.area = f.area
LEFT JOIN drivers_commission dc
    ON `order`.services = dc.services
    AND `order`.area = dc.area
GROUP BY order_date

-- 3 calculation profit

SELECT 
    o.order_date,
    SUM(o.flag_fall + (o.distance * f.drop_off)) AS revenue,
    SUM((o.flag_fall + (o.distance * f.drop_off)) * dc.commission) AS cost,
    SUM(o.flag_fall + (o.distance * f.drop_off)) 
      - SUM((o.flag_fall + (o.distance * f.drop_off)) * dc.commission) AS profit
FROM 
    `order` o
LEFT JOIN fare f
    ON o.services = f.services
    AND o.area = f.area
LEFT JOIN drivers_commission dc
    ON o.services = dc.services
    AND o.area = dc.area
GROUP BY 
    o.order_date
ORDER BY 
    profit;

--4 menghitung ARPU average revenue per user
-- rumus nya revenue / total user
-- menghitung arpu pada bulan maret
WITH kpis as (
    SELECT
        order_date,
        SUM(o.flag_fall + (o.distance * f.drop_off)) AS revenue,
        COUNT(DISTINCT user_id) as users
    FROM `order` o 
    LEFT JOIN fare f
        ON o.services = f.services
        AND o.area = f.area
    GROUP BY order_date
)
SELECT order_date, ROUND(revenue / users, 2) as arpu
FROM kpis

--5 register user KPIs

WITH reg_dates AS (
    SELECT
        user_id,
        MIN(order_date) AS reg_date 
    FROM 
        `order`
    GROUP BY 
        user_id
)
SELECT
    DATE_FORMAT(reg_date, '%Y-%m-01') AS reg_month,
    COUNT(DISTINCT user_id) AS new_users
FROM
    reg_dates
GROUP BY
    reg_month
ORDER BY
    reg_month;


--6 Growth Rate

WITH maus AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m-01') AS deliver_month,
        COUNT(DISTINCT user_id) AS mau
    FROM
        `order`
    GROUP BY
        1
), maus_lag AS (
    SELECT
        deliver_month,
        mau,
        LAG(mau) OVER(ORDER BY deliver_month ASC) AS last_mau
    FROM
        maus
)
SELECT
    deliver_month,
    mau,
    ROUND(((mau - last_mau) / last_mau), 2) AS growth
FROM
    maus_lag
ORDER BY 
    deliver_month;


--7 retention rate

WITH user_activity AS (
    SELECT
        DISTINCT
        DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
        user_id
    FROM 
        `order`
)
SELECT
    ROUND(count(DISTINCT c.user_id)/Greate)
FROM
    user_activity p 
    LEFT JOIN user_activity c 
    ON p.user_id = c.user_id
    AND p.month=DATE_SUB(c.month, INTERVAL 1 MONTH)
GROUP BY
    p.order_month

--8 bucketing

WITH user_revenue AS (
    SELECT
        user_id,
        SUM(o.flag_fall + (o.distance * f.drop_off)) AS revenue
    FROM
        `order` o
    LEFT JOIN fare f
        ON o.services = f.services
        AND o.area = f.area
    GROUP BY
        user_id
)
SELECT
    CASE 
        WHEN revenue < 100000 THEN "low revenue user"
        WHEN revenue < 300000 THEN "medium revenue user"  
        ELSE "high revenue user"
    END as revenue_group,
    COUNT(DISTINCT user_id) as users
FROM
    user_revenue
GROUP BY
    1

-- 9 percintile query

WITH user_orders AS (
    SELECT
        user_id,
        COUNT(DISTINCT order_id) AS orders
    FROM
        `order`
    GROUP BY
        user_id
)
SELECT DISTINCT
ROUND(percentile_cont)


