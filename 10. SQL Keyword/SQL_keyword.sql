-- Active: 1728529519693@@127.0.0.1@3306@sql_keyword
SHOW TABLES -- Buat tabel
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    sale_date DATETIME,
    quantity INT,
    total_amount DECIMAL(10, 2)
);

-- Masukkan data
INSERT INTO
    sales (
        sale_id,
        product_id,
        customer_id,
        sale_date,
        quantity,
        total_amount
    )
VALUES
    (1, 101, 201, '2024-02-25 08:00:00', 2, 120.00),
    (2, 102, 202, '2024-02-25 09:30:00', 1, 50.00),
    (3, 103, 201, '2024-02-26 10:15:00', 3, 180.00),
    (4, 104, 203, '2024-02-26 12:45:00', 1, 30.00),
    (5, 105, 202, '2024-02-27 14:20:00', 2, 100.00);

SELECT
    *
FROM
    sales -- Buat tabel products
    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(100),
        category_id INT,
        price DECIMAL(10, 2)
    );

-- Masukkan data
INSERT INTO
    products (product_id, product_name, category_id, price)
VALUES
    (101, 'Laptop', 1, 600.00),
    (102, 'Smartphone', 2, 50.00),
    (103, 'Headphones', 3, 60.00),
    (104, 'Tablet', 1, 30.00),
    (105, 'Camera', 4, 50.00);

SELECT
    *
FROM
    products -- Buat tabel customers
    CREATE TABLE customers (
        customer_id INT PRIMARY KEY,
        customer_name VARCHAR(100),
        email VARCHAR(100),
        country VARCHAR(50)
    );

-- Masukkan data
INSERT INTO
    customers (customer_id, customer_name, email, country)
VALUES
    (201, 'John Doe', 'john.doe@example.com', 'USA'),
    (
        202,
        'Jane Smith',
        'jane.smith@example.com',
        'Canada'
    ),
    (
        203,
        'Bob Johnson',
        'bob.johnson@example.com',
        'UK'
    ),
    (
        204,
        'Alice Brown',
        'alice.brown@example.com',
        'Australia'
    );

SELECT
    *
FROM
    customers --1 Buatlah query untuk memunculkan jenis produk yang memiliki kuantitas penjualan yang lebih besar dari rerata penjualan
SELECT
    product_name,
    AVG(quantity) as rerata_penjualan
from
    products p
    JOIN sales s ON p.product_id = s.product_id
GROUP BY
    product_name
HAVING
    AVG(quantity) > (
        SELECT
            AVG(quantity)
        FROM
            sales
    ) --2 Dengan menggunakan RANK() tentukan customer dengan total amount terbanyak pada setiap kota
SELECT
    customer_name,
    country,
    SUM(total_amount) as total_amount,
    RANK() OVER (
        PARTITION BY country
        ORDER BY
            sum(total_amount) DESC
    ) AS user_rank
FROM
    sales s
    JOIN customers c ON s.customer_id = c.customer_id
GROUP BY
    customer_name,
    country --3 Buat kategori customer berdasarkan total quantity dan amountnya sebagai berikut :
    --Low 	: total quantity 1-2 dan total amount <=100
    --Medium 	: total quantity 3-5 dan total amount 101-300
    --High	: total quantity >5 dan total amount >300
SELECT
    c.customer_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.quantity * p.price) AS total_amount,
    CASE
        WHEN SUM(s.quantity) BETWEEN 1
        AND 2
        AND SUM(s.quantity * p.price) <= 100 THEN 'Low'
        WHEN SUM(s.quantity) BETWEEN 3
        AND 5
        AND SUM(s.quantity * p.price) BETWEEN 101
        AND 300 THEN 'Medium'
        WHEN SUM(s.quantity) > 5
        AND SUM(s.quantity * p.price) > 300 THEN 'High'
        ELSE 'Unknown'
    END AS category
FROM
    customers c
    JOIN sales s ON c.customer_id = s.customer_id
    JOIN products p ON s.product_id = p.product_id
GROUP BY
    c.customer_name;

--4 Buatlah query dengan SELECT, SUM(), and the window function SUM() OVER () 
--untuk menghitung kontribusi penjualan per produk terhadap keseluruhan penjualan, baik dari segi kuantitas maupun amount.
SELECT
    p.product_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.quantity * p.price) AS total_amount,
    SUM(SUM(s.quantity)) OVER () AS total_quantity_over,
    SUM(SUM(s.quantity * p.price)) OVER () AS total_amount_over
FROM
    sales s
    JOIN products p ON s.product_id = p.product_id
GROUP BY
    p.product_name;